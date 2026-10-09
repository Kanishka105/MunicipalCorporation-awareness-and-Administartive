from __future__ import annotations

import hashlib
import math
from datetime import datetime, timezone
from typing import Any, Dict, Iterable, Optional

from fastapi import HTTPException, status

from backend.db import Database, database
from backend.schemas import DashboardStats, GPSPoint, IssueCategory, ReportCreate, ReportStatus, ResolutionPayload, Severity, TaskStatus


class CivicPulseService:
    def __init__(self, db: Optional[Database] = None):
        self.db = db or database

    def validate_submission(self, payload: ReportCreate, user: Any) -> None:
        if payload.title.strip() == "":
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Report title cannot be empty")
        if len(payload.description.strip()) < 10:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Report description must be at least 10 characters")
        if payload.gps.latitude == 0 and payload.gps.longitude == 0:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Location coordinates cannot be both zero")
        if user.role == "Citizen" and payload.citizen_id and payload.citizen_id != user.user_id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Citizens can only submit reports in their own name")

    @staticmethod
    def _hash_photo_url(url: str) -> str:
        return hashlib.sha256(url.encode("utf-8")).hexdigest()

    def _find_duplicate_report(self, payload: ReportCreate) -> Optional[Dict[str, Any]]:
        image_hash = self._hash_photo_url(payload.photo_url)
        for record in self.db.list_reports():
            if record.get("image_hash") == image_hash:
                return record
            if record.get("gps") == payload.gps.model_dump():
                return record
        return None

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
            IssueCategory.WASTE: {"label": "Municipal waste accumulation", "confidence": 0.96},
            IssueCategory.WATER: {"label": "Water quality or leakage issue", "confidence": 0.92},
            IssueCategory.AIR: {"label": "Air pollution concern", "confidence": 0.89},
            IssueCategory.DRAINAGE: {"label": "Drainage obstruction or flooding", "confidence": 0.94},
            IssueCategory.SAFETY: {"label": "Public safety concern", "confidence": 0.91},
            IssueCategory.NOISE: {"label": "Noise pollution concern", "confidence": 0.88},
            IssueCategory.OTHER: {"label": "General civic issue", "confidence": 0.78},
        }
        return mapping.get(category, {"label": "General civic issue", "confidence": 0.75})

    def create_report(self, payload: ReportCreate, user: Any) -> Dict[str, Any]:
        self.validate_submission(payload, user)
        duplicate = self._find_duplicate_report(payload)
        severity = self._calculate_severity(payload.category, payload.description)
        classification = self._classify_issue(payload.category)
        report_id = self.db.new_id("report")
        now = datetime.now(timezone.utc).isoformat()
        report = {
            "id": report_id,
            "title": payload.title,
            "description": payload.description,
            "category": payload.category.value,
            "gps": payload.gps.model_dump(),
            "photo_url": payload.photo_url,
            "citizen_id": payload.citizen_id or user.user_id,
            "status": ReportStatus.SUBMITTED.value,
            "severity": severity.value,
            "priority": self._calculate_priority(severity),
            "duplicate_of": duplicate["id"] if duplicate else None,
            "classification": classification,
            "image_hash": self._hash_photo_url(payload.photo_url),
            "created_at": now,
            "updated_at": now,
        }
        self.db.create_report(report)
        self.db.add_audit("report_submitted", report_id=report_id, user_id=user.user_id)

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

    def list_reports(self, user: Any, citizen_id: Optional[str] = None) -> list[Dict[str, Any]]:
        if user.role == "Citizen":
            records = self.db.list_reports(citizen_id or user.user_id)
        else:
            records = self.db.list_reports(citizen_id)
        return records

    def get_report(self, report_id: str, user: Any) -> Dict[str, Any]:
        report = self.db.get_report(report_id)
        if report is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Report not found")
        if user.role == "Citizen" and report.get("citizen_id") != user.user_id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You cannot access another citizen's report")
        return report

    def resolve_report(self, report_id: str, payload: ResolutionPayload, user: Any) -> Dict[str, Any]:
        report = self.get_report(report_id, user)
        task = self.db.get_task_by_report(report_id)
        if task is None:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Associated task not found")
        if user.role == "Citizen" and report.get("citizen_id") != user.user_id:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only the owner or an official can resolve a report")

        distance_m = self._distance_meters(report["gps"], payload.gps.model_dump())
        if distance_m > 100:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Resolution evidence must be near the original location")

        report["status"] = ReportStatus.RESOLVED.value
        report["updated_at"] = datetime.now(timezone.utc).isoformat()
        task["status"] = TaskStatus.RESOLVED.value
        task["updated_at"] = datetime.now(timezone.utc).isoformat()
        self.db.update_report(report_id, report)
        self.db.update_task(task["id"], task)
        self.db.add_audit("report_resolved", report_id=report_id, user_id=user.user_id, distance_m=round(distance_m, 2))
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
