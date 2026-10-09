from __future__ import annotations

import uuid
import boto3
from typing import Any

from fastapi import APIRouter, Depends, HTTPException, Query, status

from backend.config import get_settings
from backend.schemas import DashboardStats, ErrorResponse, HealthResponse, ReportCreate, ReportOut, ResolutionPayload, TaskOut, UploadPresign
from backend.security import AuthUser, get_current_user, require_roles
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


@router.post("/uploads/presign", response_model=UploadPresign)
def presign_upload(user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    settings = get_settings()
    
    if not settings.aws_access_key_id or not settings.aws_secret_access_key:
        raise HTTPException(status_code=500, detail="AWS credentials not configured")
        
    s3_client = boto3.client(
        's3',
        region_name=settings.aws_region,
        aws_access_key_id=settings.aws_access_key_id,
        aws_secret_access_key=settings.aws_secret_access_key
    )
    
    object_key = f"uploads/{user.user_id}/{uuid.uuid4().hex}.jpg"
    
    try:
        upload_url = s3_client.generate_presigned_url(
            'put_object',
            Params={
                'Bucket': settings.s3_bucket,
                'Key': object_key,
                'ContentType': 'image/jpeg'
            },
            ExpiresIn=3600
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
        
    return {"object_key": object_key, "upload_url": upload_url, "expires_in": 3600}


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


@router.get("/tasks", response_model=list[dict[str, Any]])
def list_tasks(user: AuthUser = Depends(get_current_user)) -> list[dict[str, Any]]:
    if user.role == "Citizen":
        citizen_reports = {item["id"] for item in service.list_reports(user)}
        tasks = []
        for task in service.db.list_tasks():
            if task["report_id"] in citizen_reports:
                tasks.append(task)
        return tasks
    return service.db.list_tasks()


@router.get("/dashboard", response_model=DashboardStats)
def dashboard(user: AuthUser = Depends(get_current_user)) -> DashboardStats:
    return service.get_dashboard()


@router.get("/tasks/{task_id}", response_model=dict[str, Any])
def get_task(task_id: str, user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    tasks = service.db.list_tasks()
    for task in tasks:
        if task["id"] == task_id:
            if user.role == "Citizen":
                report = service.db.get_report(task["report_id"])
                if report and report.get("citizen_id") != user.user_id:
                    raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Citizen can only view their own tasks")
            return task
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Task not found")
