from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile, status
from fastapi.responses import FileResponse

from backend.config import get_settings
from backend.schemas import DashboardStats, ErrorResponse, EvidenceUploadOut, HealthResponse, ReportCreate, ReportOut, ResolutionPayload, ResolutionVerificationPayload, TaskOut
from backend.security import AuthUser, OFFICIAL_ROLES, get_current_user, require_roles
from backend.services import service

router = APIRouter(prefix="/api/v1")


@router.get("/health", response_model=HealthResponse)
def health_check() -> dict[str, Any]:
    settings = get_settings()
    return {"status": "ok", "service": settings.app_name, "environment": settings.environment, "ready": True}


@router.get("/ready", response_model=HealthResponse)
def readiness() -> dict[str, Any]:
    settings = get_settings()
    return {"status": "ok", "service": settings.app_name, "environment": settings.environment, "ready": True}


@router.post("/uploads/presign")
def presign_upload(_user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    raise HTTPException(status_code=status.HTTP_501_NOT_IMPLEMENTED, detail="Image uploads are not configured")


@router.post("/uploads", response_model=EvidenceUploadOut, status_code=status.HTTP_201_CREATED)
async def upload_evidence(
    file: UploadFile = File(...),
    user: AuthUser = Depends(get_current_user),
) -> dict[str, Any]:
    max_bytes = get_settings().max_upload_size_mb * 1024 * 1024
    content = await file.read(max_bytes + 1)
    await file.close()
    if len(content) > max_bytes:
        raise HTTPException(status_code=status.HTTP_413_CONTENT_TOO_LARGE, detail="Image exceeds the configured upload size limit")
    evidence = service.store_uploaded_evidence(content, file.content_type or "", user)
    return {
        **evidence,
        "photo_url": f"/api/v1/evidence/{evidence['filename']}",
        "authenticity_status": "not_verified",
    }


@router.get("/evidence/{evidence_id}", name="get_uploaded_evidence")
def get_uploaded_evidence(
    evidence_id: str,
    user: AuthUser = Depends(get_current_user),
) -> FileResponse:
    filename = evidence_id.rsplit("/", 1)[-1]
    file_stem = filename.rsplit(".", 1)[0]
    evidence = service.get_uploaded_evidence(file_stem)
    if evidence is None or evidence["filename"] != filename:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Evidence not found")
    if evidence["uploaded_by"] != user.user_id and not user.is_official:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You cannot access evidence uploaded by another user")
    return FileResponse(
        service.uploaded_evidence_path(evidence),
        media_type=evidence["content_type"],
        headers={"Cache-Control": "private, no-store", "X-Content-Type-Options": "nosniff"},
    )


@router.post("/reports", response_model=dict[str, Any], status_code=status.HTTP_201_CREATED)
def create_report(payload: ReportCreate, user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    report = service.create_report(payload, user)
    return report


@router.get("/reports", response_model=list[dict[str, Any]])
def list_reports(user: AuthUser = Depends(get_current_user)) -> list[dict[str, Any]]:
    return service.list_reports(user)


@router.get("/reports/{report_id}", response_model=dict[str, Any])
def get_report(report_id: str, user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    return service.get_report(report_id, user)


@router.post("/reports/{report_id}/resolve", response_model=dict[str, Any])
def resolve_report(report_id: str, payload: ResolutionPayload, user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    return service.resolve_report(report_id, payload, user)


@router.post("/reports/{report_id}/resolution-evidence/verify", response_model=dict[str, Any])
def verify_resolution_evidence(
    report_id: str,
    payload: ResolutionVerificationPayload,
    user: AuthUser = Depends(require_roles(*OFFICIAL_ROLES)),
) -> dict[str, Any]:
    return service.verify_resolution_evidence(report_id, payload, user)


@router.get("/tasks", response_model=list[dict[str, Any]])
def list_tasks(user: AuthUser = Depends(get_current_user)) -> list[dict[str, Any]]:
    if not user.is_official:
        citizen_reports = {item["id"] for item in service.list_reports(user)}
        tasks = []
        for task in service.db.list_tasks():
            if task["report_id"] in citizen_reports:
                tasks.append(task)
        return tasks
    return service.db.list_tasks()


@router.get("/dashboard", response_model=DashboardStats)
def dashboard(user: AuthUser = Depends(require_roles(*OFFICIAL_ROLES))) -> DashboardStats:
    return service.get_dashboard()


@router.get("/tasks/{task_id}", response_model=dict[str, Any])
def get_task(task_id: str, user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    tasks = service.db.list_tasks()
    for task in tasks:
        if task["id"] == task_id:
            if not user.is_official:
                report = service.db.get_report(task["report_id"])
                if report and report.get("citizen_id") != user.user_id:
                    raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Citizen can only view their own tasks")
            return task
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Task not found")
