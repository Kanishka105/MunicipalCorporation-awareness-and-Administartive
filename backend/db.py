from __future__ import annotations

import json
import os
import sys
from decimal import Decimal
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


class DynamoDBDatabase(Database):
    """DynamoDB-backed implementation using the configured CivicPulse tables."""

    def __init__(self, aws_client_options: Dict[str, str], reports_table: str, tasks_table: str, users_table: str):
        import boto3

        self._resource = boto3.resource("dynamodb", **aws_client_options)
        self._tables = {
            "reports": self._resource.Table(reports_table),
            "tasks": self._resource.Table(tasks_table),
            "users": self._resource.Table(users_table),
        }
        self._ready = False
        super().__init__(storage_path=Path(os.getenv("CIVICPULSE_LOCAL_CACHE", Path(__file__).resolve().parent / "data" / "db.json")))

    @staticmethod
    def _from_dynamo(value: Any) -> Any:
        if isinstance(value, Decimal):
            return int(value) if value % 1 == 0 else float(value)
        if isinstance(value, dict):
            return {key: DynamoDBDatabase._from_dynamo(item) for key, item in value.items()}
        if isinstance(value, list):
            return [DynamoDBDatabase._from_dynamo(item) for item in value]
        return value

    @staticmethod
    def _to_dynamo(value: Any) -> Any:
        if isinstance(value, float):
            return Decimal(str(value))
        if isinstance(value, dict):
            return {key: DynamoDBDatabase._to_dynamo(item) for key, item in value.items()}
        if isinstance(value, list):
            return [DynamoDBDatabase._to_dynamo(item) for item in value]
        return value

    @staticmethod
    def _scan(table: Any) -> list[dict[str, Any]]:
        items: list[dict[str, Any]] = []
        response = table.scan()
        items.extend(response.get("Items", []))
        while response.get("LastEvaluatedKey"):
            response = table.scan(ExclusiveStartKey=response["LastEvaluatedKey"])
            items.extend(response.get("Items", []))
        return [DynamoDBDatabase._from_dynamo(item) for item in items]

    @classmethod
    def _write_many(cls, table: Any, items: list[dict[str, Any]], aliases: tuple[str, ...]) -> None:
        table.load()
        key_names = [key["AttributeName"] for key in table.key_schema]
        if not key_names:
            raise RuntimeError(f"DynamoDB table {table.name} has no configured key schema")
        with table.batch_writer(overwrite_by_pkeys=key_names) as batch:
            for original in items:
                item = dict(original)
                nested = item.get("record") if isinstance(item.get("record"), dict) else {}
                for key_name in key_names:
                    if key_name not in item:
                        value = next((item[name] for name in aliases if name in item), None)
                        if value is None:
                            value = next((nested[name] for name in (key_name, *aliases, "created_at", "timestamp") if name in nested), None)
                        if value is None:
                            raise RuntimeError(f"DynamoDB table {table.name} requires key attribute {key_name}; no matching record field exists")
                        item[key_name] = value
                batch.put_item(Item=cls._to_dynamo(item))

    def _persist(self) -> None:
        if not self._ready:
            return
        records = (
            ("reports", list(self.reports.values()), ("id", "report_id")),
            ("tasks", list(self.tasks.values()), ("id", "task_id")),
            ("users", list(self.users.values()), ("user_id", "id")),
            ("users", [{"user_id": f"audit#{item['id']}", "record_type": "audit", "record": item} for item in self.audit_log], ("user_id", "id")),
        )
        for table_name, items, aliases in records:
            self._write_many(self._tables[table_name], items, aliases)
        # Evidence metadata lives with report records in the configured users table
        # until a dedicated evidence table is configured.
        evidence_records = [{"user_id": f"evidence#{item['evidence_id']}", "record_type": "evidence", "record": item} for item in self.evidence.values()]
        self._write_many(self._tables["users"], evidence_records, ("user_id", "evidence_id"))

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

    def _load(self) -> None:
        # Override below to load app records plus audit/evidence envelopes.
        report_items = self._scan(self._tables["reports"])
        task_items = self._scan(self._tables["tasks"])
        for item in report_items:
            item.setdefault("id", item.get("report_id"))
        for item in task_items:
            item.setdefault("id", item.get("task_id"))
        self.reports = {item["id"]: item for item in report_items if item.get("id")}
        self.tasks = {item["id"]: item for item in task_items if item.get("id")}
        user_items = self._scan(self._tables["users"])
        self.users = {item["user_id"]: item for item in user_items if item.get("user_id") and not item.get("record_type")}
        self.audit_log = [item["record"] for item in user_items if item.get("record_type") == "audit" and isinstance(item.get("record"), dict)]
        self.evidence = {item["record"]["evidence_id"]: item["record"] for item in user_items if item.get("record_type") == "evidence" and isinstance(item.get("record"), dict)}
        self._ready = True

    def _refresh_live_records(self) -> None:
        report_items = self._scan(self._tables["reports"])
        task_items = self._scan(self._tables["tasks"])
        for item in report_items:
            item.setdefault("id", item.get("report_id"))
        for item in task_items:
            item.setdefault("id", item.get("task_id"))
        with self._lock:
            self.reports = {item["id"]: item for item in report_items if item.get("id")}
            self.tasks = {item["id"]: item for item in task_items if item.get("id")}

    def list_reports(self, citizen_id: Optional[str] = None) -> List[Dict[str, Any]]:
        self._refresh_live_records()
        return super().list_reports(citizen_id)

    def get_report(self, report_id: str) -> Optional[Dict[str, Any]]:
        self._refresh_live_records()
        return super().get_report(report_id)

    def list_tasks(self, assignee_id: Optional[str] = None) -> List[Dict[str, Any]]:
        self._refresh_live_records()
        return super().list_tasks(assignee_id)

    def get_task_by_report(self, report_id: str) -> Optional[Dict[str, Any]]:
        self._refresh_live_records()
        return super().get_task_by_report(report_id)

    def get_dashboard(self) -> Dict[str, Any]:
        self._refresh_live_records()
        return super().get_dashboard()


def create_database() -> Database:
    from backend.config import get_settings

    settings = get_settings()
    if settings.aws_dynamodb_enabled and settings.environment != "test" and "pytest" not in sys.modules:
        return DynamoDBDatabase(
            aws_client_options=settings.aws_client_options,
            reports_table=settings.dynamodb_reports_table,
            tasks_table=settings.dynamodb_tasks_table,
            users_table=settings.dynamodb_users_table,
        )
    return Database()


database = create_database()
