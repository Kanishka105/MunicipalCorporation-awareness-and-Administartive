from __future__ import annotations

import json
import os
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from threading import Lock
from typing import Any, Dict, Iterable, List, Optional
import uuid


@dataclass
class Database:
    storage_path: Path | str = field(default_factory=lambda: Path(__file__).resolve().parent / "data" / "db.json")
    reports: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    tasks: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    users: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    evidence: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    audit_log: List[Dict[str, Any]] = field(default_factory=list)
    _lock: Lock = field(default_factory=Lock, repr=False)

    def __post_init__(self) -> None:
        self.storage_path = Path(self.storage_path)
        self._load()

    def _load(self) -> None:
        if not self.storage_path.exists():
            return
        try:
            data = json.loads(self.storage_path.read_text(encoding="utf-8"))
        except (json.JSONDecodeError, OSError):
            return

        self.reports = data.get("reports", {}) or {}
        self.tasks = data.get("tasks", {}) or {}
        self.users = data.get("users", {}) or {}
        self.evidence = data.get("evidence", {}) or {}
        self.audit_log = data.get("audit_log", []) or []

    def _persist(self) -> None:
        self.storage_path.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "reports": self.reports,
            "tasks": self.tasks,
            "users": self.users,
            "evidence": self.evidence,
            "audit_log": self.audit_log,
        }
        self.storage_path.write_text(json.dumps(payload, indent=2, sort_keys=True), encoding="utf-8")

    def new_id(self, prefix: str) -> str:
        return f"{prefix}_{uuid.uuid4().hex[:12]}"

    def upsert_user(self, user: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            user_id = user["user_id"]
            self.users[user_id] = user
            self._persist()
            return user

    def get_user(self, user_id: str) -> Optional[Dict[str, Any]]:
        return self.users.get(user_id)

    def create_evidence(self, record: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            self.evidence[record["evidence_id"]] = record
            self._persist()
            return record

    def get_evidence(self, evidence_id: str) -> Optional[Dict[str, Any]]:
        with self._lock:
            return self.evidence.get(evidence_id)

    def list_evidence(self) -> List[Dict[str, Any]]:
        with self._lock:
            return list(self.evidence.values())

    def create_report(self, report: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            self.reports[report["id"]] = report
            self._persist()
            return report

    def update_report(self, report_id: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            existing = self.reports[report_id]
            existing.update(updates)
            existing["updated_at"] = datetime.now(timezone.utc).isoformat()
            self._persist()
            return existing

    def list_reports(self, citizen_id: Optional[str] = None) -> List[Dict[str, Any]]:
        with self._lock:
            records = list(self.reports.values())
            if citizen_id is not None:
                return [record for record in records if record.get("citizen_id") == citizen_id]
            return records

    def get_report(self, report_id: str) -> Optional[Dict[str, Any]]:
        with self._lock:
            return self.reports.get(report_id)

    def create_task(self, task: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            self.tasks[task["id"]] = task
            self._persist()
            return task

    def update_task(self, task_id: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            existing = self.tasks[task_id]
            existing.update(updates)
            existing["updated_at"] = datetime.now(timezone.utc).isoformat()
            self._persist()
            return existing

    def list_tasks(self, assignee_id: Optional[str] = None) -> List[Dict[str, Any]]:
        with self._lock:
            tasks = list(self.tasks.values())
            if assignee_id is not None:
                return [task for task in tasks if task.get("assignee_id") == assignee_id]
            return tasks

    def get_task_by_report(self, report_id: str) -> Optional[Dict[str, Any]]:
        with self._lock:
            for task in self.tasks.values():
                if task.get("report_id") == report_id:
                    return task
            return None

    def submit_resolution_evidence(
        self,
        report_id: str,
        task_id: str,
        evidence: Dict[str, Any],
        user_id: str,
    ) -> tuple[Dict[str, Any], Dict[str, Any]]:
        with self._lock:
            report = self.reports[report_id]
            task = self.tasks[task_id]
            history = report.setdefault("resolution_evidence_history", [])
            if report.get("status") == "resolved" or task.get("status") == "resolved":
                raise ValueError("Resolved reports cannot accept new resolution evidence")
            if history and history[-1].get("review_status") == "pending":
                raise ValueError("Resolution evidence is already awaiting review")

            history.append(evidence)
            report["resolution_evidence"] = evidence
            report["resolution_evidence_history"] = history
            report["updated_at"] = evidence["submitted_at"]
            audit = {
                "id": self.new_id("audit"),
                "message": "resolution_evidence_submitted",
                "timestamp": evidence["submitted_at"],
                "report_id": report_id,
                "user_id": user_id,
                "evidence_id": evidence["evidence_id"],
            }
            self.audit_log.append(audit)
            self._persist()
            return report, task

    def review_resolution_evidence(
        self,
        report_id: str,
        task_id: str,
        *,
        decision: str,
        reviewer_id: str,
        reason: Optional[str],
        reviewed_at: str,
    ) -> tuple[Dict[str, Any], Dict[str, Any]]:
        with self._lock:
            report = self.reports[report_id]
            task = self.tasks[task_id]
            evidence = report.get("resolution_evidence")
            if not evidence or evidence.get("review_status") != "pending":
                raise ValueError("No pending resolution evidence to review")
            if report.get("status") == "resolved" or task.get("status") == "resolved":
                raise ValueError("Resolved reports cannot be reviewed again")

            evidence["review_status"] = decision
            evidence["reviewed_by"] = reviewer_id
            evidence["reviewed_at"] = reviewed_at
            evidence["rejection_reason"] = reason if decision == "rejected" else None
            report["resolution_evidence"] = evidence
            report["resolution_evidence_history"][-1] = evidence
            if decision == "approved":
                report["status"] = "resolved"
                task["status"] = "resolved"
                audit_message = "resolution_evidence_approved"
            else:
                audit_message = "resolution_evidence_rejected"
            report["updated_at"] = reviewed_at
            task["updated_at"] = reviewed_at
            self.audit_log.append({
                "id": self.new_id("audit"),
                "message": audit_message,
                "timestamp": reviewed_at,
                "report_id": report_id,
                "user_id": reviewer_id,
                "evidence_id": evidence["evidence_id"],
                "reason": reason,
            })
            self._persist()
            return report, task

    def add_audit(self, message: str, **payload: Any) -> Dict[str, Any]:
        record = {"id": self.new_id("audit"), "message": message, "timestamp": datetime.now(timezone.utc).isoformat(), **payload}
        with self._lock:
            self.audit_log.append(record)
            self._persist()
            return record

    def get_dashboard(self) -> Dict[str, Any]:
        with self._lock:
            total_reports = len(self.reports)
            open_reports = sum(1 for report in self.reports.values() if report.get("status") not in {"resolved", "closed"})
            resolved_reports = sum(1 for report in self.reports.values() if report.get("status") == "resolved")
            escalated_reports = sum(1 for report in self.reports.values() if report.get("status") == "escalated")
            high_priority = sum(1 for report in self.reports.values() if str(report.get("priority", "")).lower() in {"high", "critical"})
            avg_sla = 0.0
            if self.tasks:
                avg_sla = sum(float(task.get("sla_hours", 0)) for task in self.tasks.values()) / len(self.tasks)
            return {
                "total_reports": total_reports,
                "open_reports": open_reports,
                "resolved_reports": resolved_reports,
                "high_priority": high_priority,
                "average_sla_hours": round(avg_sla, 2),
                "escalated_reports": escalated_reports,
            }


database = Database()
