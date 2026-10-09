from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime, timezone
from threading import Lock
from typing import Any, Dict, Iterable, List, Optional
import uuid


@dataclass
class Database:
    reports: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    tasks: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    users: Dict[str, Dict[str, Any]] = field(default_factory=dict)
    audit_log: List[Dict[str, Any]] = field(default_factory=list)
    _lock: Lock = field(default_factory=Lock, repr=False)

    def new_id(self, prefix: str) -> str:
        return f"{prefix}_{uuid.uuid4().hex[:12]}"

    def upsert_user(self, user: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            user_id = user["user_id"]
            self.users[user_id] = user
            return user

    def get_user(self, user_id: str) -> Optional[Dict[str, Any]]:
        return self.users.get(user_id)

    def create_report(self, report: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            self.reports[report["id"]] = report
            return report

    def update_report(self, report_id: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            existing = self.reports[report_id]
            existing.update(updates)
            existing["updated_at"] = datetime.now(timezone.utc).isoformat()
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
            return task

    def update_task(self, task_id: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        with self._lock:
            existing = self.tasks[task_id]
            existing.update(updates)
            existing["updated_at"] = datetime.now(timezone.utc).isoformat()
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

    def add_audit(self, message: str, **payload: Any) -> Dict[str, Any]:
        record = {"id": self.new_id("audit"), "message": message, "timestamp": datetime.now(timezone.utc).isoformat(), **payload}
        with self._lock:
            self.audit_log.append(record)
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
