from __future__ import annotations

from dataclasses import dataclass, field
import logging
from typing import Any

from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

from app.config import get_settings

logger = logging.getLogger(__name__)

ALLOWED_ROLES = {
    "Citizen",
    "FieldWorker",
    "Inspector",
    "Zonal",
    "Commissioner",
    "StateAdmin",
}

OFFICIAL_ROLES = {
    "FieldWorker",
    "Inspector",
    "Zonal",
    "Commissioner",
    "StateAdmin",
}

security_scheme = HTTPBearer(auto_error=False)


@dataclass
class AuthUser:
    user_id: str
    email: str | None = None
    username: str | None = None
    roles: list[str] = field(default_factory=lambda: ["Citizen"])
    municipality_id: str | None = None
    ward_id: str | None = None
    state_id: str | None = None
    scope: dict[str, Any] = field(default_factory=dict)

    @property
    def role(self) -> str:
        return self.roles[0] if self.roles else "Citizen"

    @property
    def is_official(self) -> bool:
        return bool(set(self.roles) & OFFICIAL_ROLES)


def _unauthorized() -> HTTPException:
    return HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Invalid or missing authentication credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )


def _demo_user_for_token(token: str | None) -> AuthUser:
    """Explicitly enabled local-only test authentication."""
    if not token:
        raise _unauthorized()

    prefixes = {
        "citizen-": "Citizen",
        "official-": "FieldWorker",
        "inspector-": "Inspector",
        "zonal-": "Zonal",
        "commissioner-": "Commissioner",
        "state-": "StateAdmin",
    }

    for prefix, role in prefixes.items():
        if token.startswith(prefix):
            user_id = token[len(prefix):]
            if user_id.strip():
                return AuthUser(
                    user_id=user_id,
                    username=user_id,
                    email=f"{user_id}@municipal.local",
                    roles=[role],
                )

    raise _unauthorized()


async def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(security_scheme),
) -> AuthUser:
    settings = get_settings()
    token = credentials.credentials if credentials else None

    # Local demo authentication is controlled by application settings.
    if settings.environment != "production" and settings.demo_auth_enabled:
        return _demo_user_for_token(token)

    if not token:
        raise _unauthorized()

    try:
        import jwt
        from jwt import PyJWKClient

        region = settings.cognito_region
        pool_id = settings.cognito_user_pool_id
        client_id = settings.cognito_client_id

        if not region or not pool_id or not client_id:
            raise RuntimeError("Cognito configuration is incomplete")

        issuer = f"https://cognito-idp.{region}.amazonaws.com/{pool_id}"
        jwks_url = f"{issuer}/.well-known/jwks.json"
        signing_key = PyJWKClient(jwks_url).get_signing_key_from_jwt(token)

        payload = jwt.decode(
            token,
            signing_key.key,
            algorithms=["RS256"],
            issuer=issuer,
            options={
                "require": ["exp", "iss", "token_use"],
                "verify_aud": False,
            },
        )

        if payload.get("token_use") != "access":
            raise _unauthorized()

        if payload.get("client_id") != client_id:
            raise _unauthorized()

        subject = payload.get("sub")
        if not isinstance(subject, str) or not subject:
            raise _unauthorized()

        raw_roles = payload.get("cognito:groups", [])
        if not isinstance(raw_roles, list):
            raw_roles = []

        if any(role not in ALLOWED_ROLES for role in raw_roles):
            raise _unauthorized()

        roles = raw_roles or ["Citizen"]

        return AuthUser(
            user_id=subject,
            email=payload.get("email"),
            username=payload.get("username"),
            roles=roles,
            municipality_id=payload.get("custom:municipality_id"),
            ward_id=payload.get("custom:ward_id"),
            state_id=payload.get("custom:state_id"),
            scope={
                "municipality": payload.get("custom:municipality_id"),
                "ward": payload.get("custom:ward_id"),
                "state": payload.get("custom:state_id"),
            },
        )

    except HTTPException:
        raise
    except Exception as exc:
        logger.warning("Authentication failed: %s", type(exc).__name__)
        raise _unauthorized() from None


def require_roles(*required_roles: str):
    if not required_roles or not set(required_roles).issubset(ALLOWED_ROLES):
        raise ValueError("Invalid required role configuration")

    def dependency(user: AuthUser = Depends(get_current_user)) -> AuthUser:
        if not set(user.roles).intersection(required_roles):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Insufficient privileges",
            )
        return user

    return dependency


def ensure_record_access(
    user: AuthUser,
    *,
    owner_id: str | None = None,
    allowed_roles: set[str] | None = None,
    municipality_id: str | None = None,
    ward_id: str | None = None,
) -> None:
    if allowed_roles and not set(user.roles).intersection(allowed_roles):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have permission for this record",
        )

    if owner_id is not None and user.user_id != owner_id:
        if "Citizen" in user.roles and not user.is_official:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="You can only access your own records",
            )

    if municipality_id is not None and "StateAdmin" not in user.roles:
        if user.municipality_id != municipality_id:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Record is outside your municipality",
            )

    if ward_id is not None and "StateAdmin" not in user.roles:
        if user.ward_id != ward_id and not ({"Commissioner", "Zonal"} & set(user.roles)):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Record is outside your ward",
            )
