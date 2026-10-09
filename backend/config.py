from __future__ import annotations

from functools import lru_cache
from typing import List

from pydantic import Field, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore", case_sensitive=False)

    app_name: str = "CivicPulse AI"
    environment: str = "development"
    demo_auth_enabled: bool = False
    secret_key: str = "dev-secret-key-do-not-use"
    aws_region: str = "ap-south-1"
    cognito_region: str = "ap-south-1"
    cognito_user_pool_id: str = "ap-south-1_example_pool"
    cognito_client_id: str = "dev-client-id"
    dynamodb_reports_table: str = "civicpulse-reports"
    dynamodb_tasks_table: str = "civicpulse-tasks"
    dynamodb_users_table: str = "civicpulse-users"
    s3_bucket: str = "civicpulse-uploads"
    max_upload_size_mb: int = 10
    ai_confidence_threshold: float = 0.75
    duplicate_similarity_threshold: float = 0.9
    default_sla_hours: int = 72
    allowed_origins: str = "http://localhost:3000,http://127.0.0.1:3000"
    require_https: bool = True

    @property
    def allowed_origin_list(self) -> List[str]:
        return [origin.strip() for origin in self.allowed_origins.split(",") if origin.strip()]

    @field_validator("environment")
    @classmethod
    def normalize_environment(cls, value: str) -> str:
        return value.strip().lower()

    @field_validator("secret_key")
    @classmethod
    def validate_secret(cls, value: str) -> str:
        if value in {"", "changeme", "dev-secret-key-do-not-use"}:
            return value
        return value

    def model_post_init(self, __context) -> None:
        if self.environment == "production":
            if self.demo_auth_enabled:
                raise ValueError("Demo authentication must be disabled in production.")
            if not self.secret_key or self.secret_key in {"dev-secret-key-do-not-use", "changeme"}:
                raise ValueError("Production requires a non-default secret_key.")
            if self.require_https and not self.allowed_origins:
                raise ValueError("Production requires configured HTTPS origins.")
            if not self.cognito_user_pool_id or self.cognito_user_pool_id.endswith("_example_pool"):
                raise ValueError("Production requires a trusted Cognito user pool configuration.")


@lru_cache(maxsize=1)
def get_settings() -> Settings:
    return Settings()
