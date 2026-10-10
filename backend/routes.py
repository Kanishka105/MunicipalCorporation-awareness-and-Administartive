from __future__ import annotations

from typing import Any
import re

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile, status
from fastapi.responses import FileResponse, Response
from pydantic import BaseModel, Field

from backend.config import get_settings
from backend.schemas import DashboardStats, ErrorResponse, EvidenceUploadOut, HealthResponse, ReportCreate, ReportOut, ResolutionPayload, ResolutionVerificationPayload, TaskOut
from backend.security import AuthUser, OFFICIAL_ROLES, get_current_user, require_roles
from backend.services import service

router = APIRouter(prefix="/api/v1")


class DashboardSignup(BaseModel):
    mobile: str = Field(min_length=10, max_length=16)
    password: str = Field(min_length=8, max_length=256)
    name: str = Field(min_length=2, max_length=120)


class DashboardLogin(BaseModel):
    mobile: str = Field(min_length=10, max_length=16)
    password: str = Field(min_length=1, max_length=256)


class DashboardConfirm(BaseModel):
    mobile: str = Field(min_length=10, max_length=16)
    code: str = Field(min_length=4, max_length=12)


class DashboardChallenge(BaseModel):
    mobile: str = Field(min_length=10, max_length=16)
    code: str = Field(min_length=4, max_length=12)
    session: str = Field(min_length=1, max_length=8192)
    challenge_name: str = Field(pattern=r"^(SMS_MFA|SOFTWARE_TOKEN_MFA)$")


def _normalize_mobile(value: str) -> str:
    digits = re.sub(r"\D", "", value)
    if len(digits) == 10 and digits[0] in "6789":
        digits = f"91{digits}"
    if not re.fullmatch(r"91[6-9]\d{9}", digits):
        raise HTTPException(status_code=422, detail="Enter a valid Indian mobile number with country code +91")
    return f"+{digits}"


def _cognito_client():
    import boto3

    settings = get_settings()
    options = settings.aws_client_options | {"region_name": settings.cognito_region}
    return boto3.client("cognito-idp", **options)


def _dashboard_client_id() -> str:
    settings = get_settings()
    client_id = settings.dashboard_cognito_client_id or settings.cognito_client_id
    if not client_id or client_id == "dev-client-id":
        raise HTTPException(status_code=503, detail="Dashboard Cognito app client is not configured")
    return client_id


@router.post("/auth/signup")
def dashboard_signup(payload: DashboardSignup) -> dict[str, Any]:
    """Create an unprivileged Cognito account; officials need admin role assignment."""
    from botocore.exceptions import ClientError

    try:
        result = _cognito_client().sign_up(
            ClientId=_dashboard_client_id(),
            Username=_normalize_mobile(payload.mobile),
            Password=payload.password,
            UserAttributes=[
                {"Name": "phone_number", "Value": _normalize_mobile(payload.mobile)},
                {"Name": "name", "Value": payload.name.strip()},
            ],
        )
    except ClientError as exc:
        error_code = exc.response.get("Error", {}).get("Code")
        if error_code == "UsernameExistsException":
            raise HTTPException(status_code=409, detail="An account already exists for this mobile number") from None
        if error_code in {"InvalidPasswordException", "InvalidParameterException"}:
            raise HTTPException(status_code=400, detail="Cognito rejected the signup details; check the password policy and required attributes") from None
        raise HTTPException(status_code=502, detail="Cognito signup failed; check backend AWS permissions and user-pool settings") from None
    return {"user_confirmed": result.get("UserConfirmed", False), "code_delivery": result.get("CodeDeliveryDetails", {}).get("DeliveryMedium", "SMS")}


@router.post("/auth/confirm")
def dashboard_confirm(payload: DashboardConfirm) -> dict[str, str]:
    from botocore.exceptions import ClientError

    try:
        _cognito_client().confirm_sign_up(
            ClientId=_dashboard_client_id(),
            Username=_normalize_mobile(payload.mobile),
            ConfirmationCode=payload.code.strip(),
        )
    except ClientError as exc:
        error_code = exc.response.get("Error", {}).get("Code")
        if error_code in {"CodeMismatchException", "ExpiredCodeException"}:
            raise HTTPException(status_code=400, detail="The verification code is invalid or expired") from None
        if error_code == "NotAuthorizedException":
            raise HTTPException(status_code=409, detail="This account is already confirmed") from None
        raise HTTPException(status_code=502, detail="Cognito confirmation failed; check SMS delivery and user-pool settings") from None
    return {"status": "confirmed"}


@router.post("/auth/login")
def dashboard_login(payload: DashboardLogin) -> dict[str, Any]:
    from botocore.exceptions import ClientError

    try:
        result = _cognito_client().initiate_auth(
            ClientId=_dashboard_client_id(),
            AuthFlow="USER_PASSWORD_AUTH",
            AuthParameters={"USERNAME": _normalize_mobile(payload.mobile), "PASSWORD": payload.password},
        )
    except ClientError as exc:
        error_code = exc.response.get("Error", {}).get("Code")
        if error_code in {"NotAuthorizedException", "UserNotFoundException", "UserNotConfirmedException"}:
            raise HTTPException(status_code=401, detail="Invalid credentials or unverified mobile number") from None
        raise HTTPException(status_code=502, detail="Cognito login failed; check the app-client auth flow and user-pool settings") from None

    if result.get("ChallengeName"):
        return {
            "challenge_name": result["ChallengeName"],
            "session": result.get("Session", ""),
        }
    auth = result.get("AuthenticationResult", {})
    if not auth.get("AccessToken"):
        raise HTTPException(status_code=502, detail="Cognito did not return an access token")
    return {
        "access_token": auth["AccessToken"],
        "token_type": auth.get("TokenType", "Bearer"),
        "expires_in": auth.get("ExpiresIn", 3600),
        "refresh_token": auth.get("RefreshToken"),
    }


@router.post("/auth/challenge")
def dashboard_auth_challenge(payload: DashboardChallenge) -> dict[str, Any]:
    from botocore.exceptions import ClientError

    response_key = "SMS_MFA_CODE" if payload.challenge_name == "SMS_MFA" else "SOFTWARE_TOKEN_MFA_CODE"
    try:
        result = _cognito_client().respond_to_auth_challenge(
            ClientId=_dashboard_client_id(),
            ChallengeName=payload.challenge_name,
            Session=payload.session,
            ChallengeResponses={
                "USERNAME": _normalize_mobile(payload.mobile),
                response_key: payload.code.strip(),
            },
        )
    except ClientError as exc:
        error_code = exc.response.get("Error", {}).get("Code")
        if error_code in {"CodeMismatchException", "NotAuthorizedException"}:
            raise HTTPException(status_code=401, detail="The verification code is invalid or expired") from None
        raise HTTPException(status_code=502, detail="Cognito could not complete the verification challenge") from None
    auth = result.get("AuthenticationResult", {})
    if not auth.get("AccessToken"):
        raise HTTPException(status_code=502, detail="Cognito did not return an access token")
    return {
        "access_token": auth["AccessToken"],
        "token_type": auth.get("TokenType", "Bearer"),
        "expires_in": auth.get("ExpiresIn", 3600),
        "refresh_token": auth.get("RefreshToken"),
    }


@router.get("/auth/me")
def dashboard_me(user: AuthUser = Depends(get_current_user)) -> dict[str, Any]:
    return {
        "user_id": user.user_id,
        "mobile": user.username,
        "email": user.email,
        "roles": user.roles,
        "municipality_id": user.municipality_id,
        "ward_id": user.ward_id,
        "state_id": user.state_id,
    }


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


@router.get("/evidence/{evidence_id}", name="get_uploaded_evidence", response_model=None)
def get_uploaded_evidence(
    evidence_id: str,
    user: AuthUser = Depends(get_current_user),
) -> FileResponse | Response:
    filename = evidence_id.rsplit("/", 1)[-1]
    file_stem = filename.rsplit(".", 1)[0]
    evidence = service.get_uploaded_evidence(file_stem)
    if evidence is None or evidence["filename"] != filename:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Evidence not found")
    if evidence["uploaded_by"] != user.user_id and not user.is_official:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You cannot access evidence uploaded by another user")
    if evidence.get("object_key"):
        import boto3

        settings = get_settings()
        try:
            s3_object = boto3.client("s3", **settings.aws_client_options).get_object(
                Bucket=settings.s3_bucket,
                Key=evidence["object_key"],
            )
            content = s3_object["Body"].read()
        except Exception as exc:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Evidence file unavailable in S3") from exc
        return Response(
            content=content,
            media_type=evidence["content_type"],
            headers={"Cache-Control": "private, no-store", "X-Content-Type-Options": "nosniff"},
        )
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
