from __future__ import annotations

from datetime import datetime
from enum import Enum
from typing import Any, Dict, List, Literal, Optional

from pydantic import BaseModel, ConfigDict, Field, field_validator


class IssueCategory(str, Enum):
    WASTE = "waste"
    WATER = "water"
    AIR = "air"
    DRAINAGE = "drainage"
    SAFETY = "safety"
    NOISE = "noise"
    OTHER = "other"


class ReportStatus(str, Enum):
    SUBMITTED = "submitted"
    IN_REVIEW = "in_review"
    ASSIGNED = "assigned"
    RESOLVED = "resolved"
    REOPENED = "reopened"
    ESCALATED = "escalated"


class TaskStatus(str, Enum):
    OPEN = "open"
    IN_PROGRESS = "in_progress"
    RESOLVED = "resolved"
    REOPENED = "reopened"
    ESCALATED = "escalated"


class Severity(str, Enum):
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    CRITICAL = "critical"


class GPSPoint(BaseModel):
    latitude: float = Field(..., ge=-90, le=90)
    longitude: float = Field(..., ge=-180, le=180)


class PhotoEvidence(BaseModel):
    url: str = Field(..., min_length=5)
    gps: GPSPoint
    caption: Optional[str] = None


class ReportCreate(BaseModel):
    title: str = Field(..., min_length=3, max_length=120)
    description: str = Field(..., min_length=10, max_length=2000)
    category: IssueCategory = IssueCategory.WASTE
    gps: GPSPoint
    photo_url: str = Field(..., min_length=5)
    citizen_id: str = "anonymous"

    @field_validator("photo_url")
    @classmethod
    def validate_photo_url(cls, value: str) -> str:
        cleaned = value.strip()
        lowercase = cleaned.lower()
        if not lowercase.startswith(("http://", "https://")):
            raise ValueError("photo_url must be a valid URL")
        if not any(lowercase.endswith(ext) for ext in (".jpg", ".jpeg", ".png", ".webp")):
            raise ValueError("photo_url must point to a supported image file")
        return cleaned


class ResolutionPayload(BaseModel):
    resolution_photo_url: str = Field(..., min_length=5)
    gps: GPSPoint
    comments: Optional[str] = None


class ReportOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    title: str
    description: str
    category: IssueCategory
    gps: GPSPoint
    photo_url: str
    citizen_id: str
    status: ReportStatus
    severity: Severity
    priority: str
    duplicate_of: Optional[str] = None
    classification: Dict[str, Any] = Field(default_factory=dict)
    created_at: datetime
    updated_at: datetime


class TaskOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: str
    report_id: str
    assignee_id: str
    status: TaskStatus
    priority: str
    sla_hours: int
    created_at: datetime
    updated_at: datetime


class DashboardStats(BaseModel):
    total_reports: int
    open_reports: int
    resolved_reports: int
    high_priority: int
    average_sla_hours: float
    escalated_reports: int


class UploadPresign(BaseModel):
    object_key: str
    upload_url: str
    expires_in: int


class ErrorResponse(BaseModel):
    error: str
    details: Optional[str] = None
    request_id: Optional[str] = None


class HealthResponse(BaseModel):
    status: Literal["ok", "degraded"]
    service: str
    environment: str
    ready: bool = True
