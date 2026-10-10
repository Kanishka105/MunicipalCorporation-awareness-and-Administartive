from __future__ import annotations

import uuid
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.exceptions import HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

from backend.config import get_settings
from backend.routes import router


@asynccontextmanager
async def lifespan(app: FastAPI):
    settings = get_settings()
    app.state.settings = settings
    yield


app = FastAPI(title="CivicPulse AI", version="0.1.0", lifespan=lifespan)
origins = get_settings().allowed_origin_list
if get_settings().environment != "production":
    origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_origin_regex=r"^https?://.*" if get_settings().environment != "production" else None,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.middleware("http")
async def request_id_middleware(request: Request, call_next):
    request_id = request.headers.get("x-request-id") or str(uuid.uuid4())
    response = await call_next(request)
    response.headers["x-request-id"] = request_id
    return response


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request: Request, exc: StarletteHTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={"error": exc.detail if isinstance(exc.detail, str) else "Request failed", "request_id": request.headers.get("x-request-id")},
    )


@app.exception_handler(Exception)
async def generic_exception_handler(request: Request, exc: Exception):
    return JSONResponse(
        status_code=500,
        content={"error": "internal_server_error", "details": "The server encountered an unexpected error", "request_id": request.headers.get("x-request-id")},
    )


@app.get("/health")
def health():
    settings = get_settings()
    return {"status": "ok", "service": settings.app_name, "environment": settings.environment, "ready": True}


@app.get("/ready")
def ready():
    settings = get_settings()
    return {"status": "ok", "service": settings.app_name, "environment": settings.environment, "ready": True}


app.include_router(router)

try:
    from mangum import Mangum
    handler = Mangum(app)
except ImportError:  # pragma: no cover - only for missing optional dependency
    handler = None
