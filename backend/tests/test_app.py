import pytest
from fastapi.testclient import TestClient

from backend import security
from backend.config import Settings
from backend.db import database
from backend.main import app

client = TestClient(app)


@pytest.fixture(autouse=True)
def enable_demo_auth_for_non_production_tests(monkeypatch):
    settings = Settings(
        environment="test",
        demo_auth_enabled=True,
        _env_file=None,
    )
    monkeypatch.setattr(security, "get_settings", lambda: settings)
    database.reports.clear()
    database.tasks.clear()
    database.audit_log.clear()


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    body = response.json()
    assert body["status"] == "ok"
    assert body["ready"] is True


def test_report_creation_and_list():
    payload = {
        "title": "Overflowing civic waste bin",
        "description": "Large volumes of municipal waste have accumulated near the market and are creating a hygiene issue.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": "https://example.com/waste-bin.jpg",
        "citizen_id": "citizen-demo-1",
    }

    response = client.post(
        "/api/v1/reports",
        json=payload,
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )
    assert response.status_code == 201, response.text
    report = response.json()
    assert report["title"] == payload["title"]
    assert report["status"] == "submitted"
    assert report["id"]

    list_response = client.get(
        "/api/v1/reports",
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )
    assert list_response.status_code == 200
    assert any(item["id"] == report["id"] for item in list_response.json())


def test_citizen_cannot_submit_for_another_user():
    payload = {
        "title": "Unauthorized report",
        "description": "This report indicates a blocked drain, which needs urgent attention in the residential area.",
        "category": "drainage",
        "gps": {"latitude": 19.0761, "longitude": 72.8778},
        "photo_url": "https://example.com/drainage.jpg",
        "citizen_id": "another-user",
    }

    response = client.post(
        "/api/v1/reports",
        json=payload,
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )
    assert response.status_code == 403
    assert "only submit reports in their own name" in response.json()["error"]


def test_resolution_workflow_success_for_official():
    payload = {
        "title": "Street flooding near school",
        "description": "A blocked drain is causing standing water outside the primary school and severe traffic disruption.",
        "category": "drainage",
        "gps": {"latitude": 19.0765, "longitude": 72.8780},
        "photo_url": "https://example.com/flooding.jpg",
        "citizen_id": "citizen-demo-1",
    }

    create_response = client.post(
        "/api/v1/reports",
        json=payload,
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )
    assert create_response.status_code == 201, create_response.text
    report_id = create_response.json()["id"]
    assert report_id

    resolve_payload = {
        "resolution_photo_url": "https://example.com/resolution-flooding.jpg",
        "gps": {"latitude": 19.0765, "longitude": 72.8780},
        "comments": "Drain cleared and water removed from the roadway.",
    }

    response = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json=resolve_payload,
        headers={"Authorization": "Bearer official-field-worker-1"},
    )
    assert response.status_code == 200, response.text
    body = response.json()
    assert body["report"]["status"] == "resolved"
    assert body["task"]["status"] == "resolved"
