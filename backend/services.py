from __future__ import annotations

import hashlib
import math
import os
import re
import sys
import warnings
from io import BytesIO
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Optional
from urllib.parse import unquote, urlsplit, urlunsplit
import uuid

from fastapi import HTTPException, status
from PIL import Image, UnidentifiedImageError

from backend.config import get_settings
from backend.db import Database, database
from backend.schemas import DashboardStats, IssueCategory, ReportCreate, ReportStatus, ResolutionPayload, ResolutionVerificationPayload, Severity, TaskStatus


class CivicPulseService:
    def __init__(self, db: Optional[Database] = None):
        self.db = db or database

    @staticmethod
    def _normalize_citizen_id(citizen_id: str | None, fallback_user_id: str) -> str:
        if citizen_id is None:
            return fallback_user_id
        cleaned = citizen_id.strip()
        if not cleaned or cleaned.lower() == "anonymous":
            return fallback_user_id
        return cleaned

    def validate_submission(self, payload: ReportCreate, user: Any) -> None:
        if payload.title.strip() == "":
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Report title cannot be empty")
        if len(payload.description.strip()) < 10:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Report description must be at least 10 characters")
        if payload.gps.latitude == 0 and payload.gps.longitude == 0:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Location coordinates cannot be both zero")

        normalized_citizen_id = self._normalize_citizen_id(payload.citizen_id, user.user_id)
        if not user.is_official and "Citizen" in user.roles and normalized_citizen_id != user.user_id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Citizens can only submit reports in their own name")

    @staticmethod
    def _hash_photo_bytes(content: bytes) -> str:
        return hashlib.sha256(content).hexdigest()

    @staticmethod
    def _canonical_photo_url(url: str) -> str:
        parsed = urlsplit(url.strip())
        return urlunsplit((parsed.scheme.lower(), parsed.netloc.lower(), parsed.path, "", ""))

    @staticmethod
    def _evidence_id_from_url(url: str) -> Optional[str]:
        filename = unquote(urlsplit(url).path.rsplit("/", 1)[-1])
        match = re.fullmatch(r"([0-9a-f]{32})\.(jpg|png|webp)", filename)
        return match.group(1) if match else None

    def _uploaded_evidence(self, url: str) -> Optional[Dict[str, Any]]:
        evidence_id = self._evidence_id_from_url(url)
        if evidence_id is None:
            return None
        evidence = self.db.get_evidence(evidence_id)
        if evidence is None or urlsplit(url).path != f"/api/v1/evidence/{evidence['filename']}":
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Uploaded evidence reference is invalid")
        return evidence

    def _validate_evidence_owner(self, url: str, user: Any) -> Optional[Dict[str, Any]]:
        evidence = self._uploaded_evidence(url)
        if evidence is not None and evidence["uploaded_by"] != user.user_id and not user.is_official:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You cannot use evidence uploaded by another user")
        return evidence

    def store_uploaded_evidence(self, content: bytes, content_type: str, user: Any) -> Dict[str, Any]:
        if not content:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Uploaded image is empty")
        signatures = (
            (b"\xff\xd8\xff", "image/jpeg", "jpg"),
            (b"\x89PNG\r\n\x1a\n", "image/png", "png"),
        )
        detected = next(
            ((media_type, extension) for signature, media_type, extension in signatures if content.startswith(signature)),
            None,
        )
        if detected is None and len(content) >= 12 and content[:4] == b"RIFF" and content[8:12] == b"WEBP":
            detected = ("image/webp", "webp")
        if detected is None:
            raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE, detail="Only JPEG, PNG, and WebP image files are supported")
        detected_type, extension = detected
        if content_type.lower().split(";", 1)[0].strip() != detected_type:
            raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE, detail="Image content does not match the declared media type")
        try:
            with warnings.catch_warnings():
                warnings.simplefilter("error", Image.DecompressionBombWarning)
                with Image.open(BytesIO(content)) as image:
                    if image.format != {"image/jpeg": "JPEG", "image/png": "PNG", "image/webp": "WEBP"}[detected_type]:
                        raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE, detail="Image content is invalid")
                    if image.width * image.height > 20_000_000:
                        raise HTTPException(status_code=status.HTTP_413_CONTENT_TOO_LARGE, detail="Image dimensions exceed the supported limit")
                    image.verify()
        except (Image.DecompressionBombError, Image.DecompressionBombWarning, UnidentifiedImageError, OSError) as exc:
            raise HTTPException(status_code=status.HTTP_415_UNSUPPORTED_MEDIA_TYPE, detail="Uploaded file is not a valid supported image") from exc

        evidence_id = uuid.uuid4().hex
        filename = f"{evidence_id}.{extension}"
        record = {
            "evidence_id": evidence_id,
            "filename": filename,
            "content_type": detected_type,
            "size_bytes": len(content),
            "content_sha256": self._hash_photo_bytes(content),
            "uploaded_by": user.user_id,
            "created_at": datetime.now(timezone.utc).isoformat(),
        }
        settings = get_settings()
        if settings.aws_s3_enabled and "pytest" not in sys.modules:
            if not settings.s3_bucket:
                raise HTTPException(status_code=status.HTTP_503_SERVICE_UNAVAILABLE, detail="S3 bucket is not configured")
            import boto3

            object_key = f"evidence/{filename}"
            boto3.client("s3", **settings.aws_client_options).put_object(
                Bucket=settings.s3_bucket,
                Key=object_key,
                Body=content,
                ContentType=detected_type,
                ServerSideEncryption="AES256",
                Metadata={"sha256": record["content_sha256"]},
            )
            record["object_key"] = object_key
        else:
            directory = Path(self.db.storage_path).parent / "evidence"
            directory.mkdir(mode=0o700, parents=True, exist_ok=True)
            os.chmod(directory, 0o700)
            destination = directory / filename
            file_descriptor = os.open(destination, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
            try:
                with os.fdopen(file_descriptor, "wb") as image_file:
                    image_file.write(content)
            except OSError:
                destination.unlink(missing_ok=True)
                raise
        self.db.create_evidence(record)
        return record

    def get_uploaded_evidence(self, evidence_id: str) -> Optional[Dict[str, Any]]:
        return self.db.get_evidence(evidence_id)

    def uploaded_evidence_path(self, evidence: Dict[str, Any]) -> Path:
        if evidence.get("object_key"):
            raise HTTPException(status_code=status.HTTP_501_NOT_IMPLEMENTED, detail="S3 evidence is returned directly by the evidence endpoint")
        path = Path(self.db.storage_path).parent / "evidence" / evidence["filename"]
        if not path.is_file():
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Evidence file is unavailable")
        return path

    @staticmethod
    def _evidence_risk(
        url: str,
        *,
        reused_reference: bool = False,
        content_hash_reused: bool = False,
        has_content_hash: bool = False,
    ) -> Dict[str, Any]:
        signals = ["image_bytes_and_capture_metadata_not_verified"]
        risk_score = 35
        if urlsplit(url).scheme.lower() != "https":
            signals.append("insecure_image_transport")
            risk_score += 30
        if reused_reference:
            signals.append("image_reference_reused")
            signals.append("image_reference_reuse_is_not_content_verification")
            risk_score += 20
        if content_hash_reused:
            signals.append("exact_image_content_reused")
            risk_score += 45
        if has_content_hash:
            signals.append("image_content_sha256_available")
        return {
            "authenticity_status": "not_verified",
            "risk_score": min(risk_score, 100),
            "risk_level": "high" if risk_score >= 70 else "medium" if risk_score >= 40 else "low",
            "signals": signals,
        }

    def _find_duplicate_report(
        self,
        payload: ReportCreate,
        *,
        content_sha256: Optional[str] = None,
    ) -> tuple[Optional[Dict[str, Any]], bool, bool]:
        for record in self.db.list_reports():
            active = record.get("status") not in {ReportStatus.RESOLVED.value, "closed"}
            if not active:
                continue
            same_content = bool(content_sha256 and record.get("image_hash") == content_sha256)
            same_reference = self._canonical_photo_url(record.get("photo_url", "")) == self._canonical_photo_url(payload.photo_url)
            if same_content or same_reference:
                return record, same_content, same_reference
            if active and self._distance_meters(record.get("gps", {}), payload.gps.model_dump()) <= 50:
                return record, False, False
        return None, False, False

    @staticmethod
    def _calculate_severity(category: IssueCategory, description: str) -> Severity:
        score = 0
        if category in {IssueCategory.WASTE, IssueCategory.DRAINAGE}:
            score += 2
        if category in {IssueCategory.WATER, IssueCategory.AIR}:
            score += 2
        if "urgent" in description.lower() or "hazard" in description.lower() or "flood" in description.lower():
            score += 2
        if len(description) > 350:
            score += 1
        if score >= 4:
            return Severity.CRITICAL
        if score == 3:
            return Severity.HIGH
        if score == 2:
            return Severity.MEDIUM
        return Severity.LOW

    @staticmethod
    def _calculate_priority(severity: Severity) -> str:
        return {
            Severity.LOW: "Low",
            Severity.MEDIUM: "Medium",
            Severity.HIGH: "High",
            Severity.CRITICAL: "Critical",
        }[severity]

    @staticmethod
    def _classify_issue(category: IssueCategory) -> Dict[str, Any]:
        mapping = {
            IssueCategory.WASTE: "Municipal waste accumulation",
            IssueCategory.WATER: "Water quality or leakage issue",
            IssueCategory.AIR: "Air pollution concern",
            IssueCategory.DRAINAGE: "Drainage obstruction or flooding",
            IssueCategory.SAFETY: "Public safety concern",
            IssueCategory.NOISE: "Noise pollution concern",
            IssueCategory.OTHER: "General civic issue",
        }
        return {
            "label": mapping.get(category, "General civic issue"),
            "method": "rule_based",
            "model_inference": False,
        }

    def create_report(self, payload: ReportCreate, user: Any) -> Dict[str, Any]:
        self.validate_submission(payload, user)
        evidence = self._validate_evidence_owner(payload.photo_url, user)
        content_sha256 = evidence["content_sha256"] if evidence else None
        duplicate, exact_content_reused, reused_reference = self._find_duplicate_report(
            payload,
            content_sha256=content_sha256,
        )
        severity = self._calculate_severity(payload.category, payload.description)
        classification = self._classify_issue(payload.category)
        report_id = self.db.new_id("report")
        now = datetime.now(timezone.utc).isoformat()
        citizen_id = self._normalize_citizen_id(payload.citizen_id, user.user_id)
        author_name = user.scope.get("name") or user.username or citizen_id
        report = {
            "id": report_id,
            "title": payload.title,
            "description": payload.description,
            "category": payload.category.value,
            "gps": payload.gps.model_dump(),
            "latitude": payload.gps.latitude,
            "longitude": payload.gps.longitude,
            "lat": payload.gps.latitude,
            "long": payload.gps.longitude,
            "photo_url": payload.photo_url,
            "citizen_id": citizen_id,
            "author_name": author_name,
            "upvotes": 0,
            "upvoters": [],
            "gps_accuracy_m": payload.gps_accuracy_m,
            "status": ReportStatus.SUBMITTED.value,
            "severity": severity.value,
            "priority": self._calculate_priority(severity),
            "duplicate_of": duplicate["id"] if duplicate else None,
            "classification": classification,
            "image_hash": content_sha256,
            "image_hash_kind": "sha256_content" if content_sha256 else None,
            "evidence_risk": self._evidence_risk(
                payload.photo_url,
                reused_reference=reused_reference and not exact_content_reused,
                content_hash_reused=exact_content_reused,
                has_content_hash=bool(content_sha256),
            ),
            "created_at": now,
            "updated_at": now,
        }
        self.db.create_report(report)
        self.db.add_audit("report_submitted", report_id=report_id, user_id=user.user_id)

        # Save post metadata and lat/long to AWS S3 if enabled
        settings = get_settings()
        if settings.aws_s3_enabled and "pytest" not in sys.modules:
            try:
                import boto3, json
                s3_key = f"posts/{report_id}.json"
                boto3.client("s3", **settings.aws_client_options).put_object(
                    Bucket=settings.s3_bucket,
                    Key=s3_key,
                    Body=json.dumps(report, default=str).encode("utf-8"),
                    ContentType="application/json",
                    Metadata={
                        "report_id": report_id,
                        "citizen_id": str(citizen_id),
                        "latitude": str(payload.gps.latitude),
                        "longitude": str(payload.gps.longitude),
                        "lat": str(payload.gps.latitude),
                        "long": str(payload.gps.longitude),
                        "category": str(payload.category.value),
                    },
                )
                report["s3_key"] = s3_key
            except Exception as exc:
                pass

        task = {
            "id": self.db.new_id("task"),
            "report_id": report_id,
            "assignee_id": "officer-001",
            "status": TaskStatus.OPEN.value,
            "priority": report["priority"],
            "sla_hours": 72,
            "created_at": now,
            "updated_at": now,
        }
        self.db.create_task(task)
        return report

    def list_reports(self, user: Any, citizen_id: Optional[str] = None, mine: bool = False) -> list[Dict[str, Any]]:
        if mine:
            records = self.db.list_reports()
            user_keys = {user.user_id, getattr(user, "username", None)} - {None}
            return [r for r in records if r.get("citizen_id") in user_keys]
        if citizen_id is not None:
            effective_citizen_id = self._normalize_citizen_id(citizen_id, user.user_id)
            return self.db.list_reports(effective_citizen_id)
        return self.db.list_reports()

    def get_report(self, report_id: str, user: Any) -> Dict[str, Any]:
        report = self.db.get_report(report_id)
        if report is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Report not found")
        return report

    def upvote_report(self, report_id: str, user: Any) -> Dict[str, Any]:
        report = self.db.get_report(report_id)
        if report is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Report not found")

        upvoters = list(report.get("upvoters") or [])
        user_key = user.user_id or user.username or "anonymous"
        if user_key in upvoters:
            upvoters.remove(user_key)
            has_upvoted = False
        else:
            upvoters.append(user_key)
            has_upvoted = True

        updates = {
            "upvotes": len(upvoters),
            "upvoters": upvoters,
        }
        updated = self.db.update_report(report_id, updates)

        settings = get_settings()
        if settings.aws_s3_enabled and "pytest" not in sys.modules:
            try:
                import boto3, json
                s3_key = f"posts/{report_id}.json"
                boto3.client("s3", **settings.aws_client_options).put_object(
                    Bucket=settings.s3_bucket,
                    Key=s3_key,
                    Body=json.dumps(updated, default=str).encode("utf-8"),
                    ContentType="application/json",
                )
            except Exception:
                pass

        return {
            "report_id": report_id,
            "upvotes": len(upvoters),
            "has_upvoted": has_upvoted,
            "upvoters": upvoters,
        }

    def resolve_report(self, report_id: str, payload: ResolutionPayload, user: Any) -> Dict[str, Any]:
        if not user.is_official:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only authorized officials can resolve reports")

        report = self.get_report(report_id, user)
        task = self.db.get_task_by_report(report_id)
        if task is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Associated task not found")
        evidence_upload = self._validate_evidence_owner(payload.resolution_photo_url, user)
        if not evidence_upload and urlsplit(payload.resolution_photo_url).scheme.lower() != "https":
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Resolution evidence must use HTTPS")

        if self._canonical_photo_url(payload.resolution_photo_url) == self._canonical_photo_url(report["photo_url"]):
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Resolution evidence must use an image reference different from the original evidence",
            )
        content_sha256 = evidence_upload["content_sha256"] if evidence_upload else None
        if content_sha256 and content_sha256 == report.get("image_hash"):
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Resolution image content must differ from the original evidence")

        distance_m = self._distance_meters(report["gps"], payload.gps.model_dump())
        if distance_m > 50:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Resolution evidence must be within 50 meters of the original location")

        submitted_at = datetime.now(timezone.utc).isoformat()
        resolution_evidence = {
            "evidence_id": uuid.uuid4().hex,
            "photo_url": payload.resolution_photo_url,
            "gps": payload.gps.model_dump(),
            "comments": payload.comments,
            "submitted_at": submitted_at,
            "distance_from_report_m": round(distance_m, 2),
            "content_sha256": content_sha256,
            "authenticity_status": "not_verified",
            "review_status": "pending",
            "review_type": "manual_official_review",
            "evidence_risk": self._evidence_risk(
                payload.resolution_photo_url,
                has_content_hash=bool(content_sha256),
            ),
        }
        try:
            report, task = self.db.submit_resolution_evidence(
                report_id,
                task["id"],
                resolution_evidence,
                user.user_id,
            )
        except ValueError as exc:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=str(exc)) from exc
        return {"report": report, "task": task}

    def verify_resolution_evidence(
        self,
        report_id: str,
        payload: ResolutionVerificationPayload,
        user: Any,
    ) -> Dict[str, Any]:
        if not user.is_official:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only authorized officials can review resolution evidence")
        self.get_report(report_id, user)
        task = self.db.get_task_by_report(report_id)
        if task is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Associated task not found")
        reviewed_at = datetime.now(timezone.utc).isoformat()
        try:
            report, task = self.db.review_resolution_evidence(
                report_id,
                task["id"],
                decision=payload.decision.value,
                reviewer_id=user.user_id,
                reason=payload.reason,
                reviewed_at=reviewed_at,
            )
        except ValueError as exc:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=str(exc)) from exc
        return {"report": report, "task": task}

    @staticmethod
    def _distance_meters(point_a: Dict[str, float], point_b: Dict[str, float]) -> float:
        lat1, lon1 = math.radians(point_a["latitude"]), math.radians(point_a["longitude"])
        lat2, lon2 = math.radians(point_b["latitude"]), math.radians(point_b["longitude"])
        dlat = lat2 - lat1
        dlon = lon2 - lon1
        a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
        return 6371000 * c

    def get_dashboard(self) -> DashboardStats:
        summary = self.db.get_dashboard()
        return DashboardStats(**summary)


service = CivicPulseService(database)
