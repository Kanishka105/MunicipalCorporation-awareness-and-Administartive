import pytest
from io import BytesIO
from PIL import Image
from fastapi.testclient import TestClient

from backend import security
from backend.config import Settings
from backend.db import database
from backend.main import app

client = TestClient(app)


@pytest.fixture(autouse=True)
def enable_demo_auth_for_non_production_tests(monkeypatch, tmp_path):
    settings = Settings(
        environment="test",
        demo_auth_enabled=True,
        _env_file=None,
    )
    monkeypatch.setattr(security, "get_settings", lambda: settings)
    monkeypatch.setattr(database, "storage_path", tmp_path / "db.json")
    database.reports.clear()
    database.tasks.clear()
    database.audit_log.clear()
    database.evidence.clear()


def _png_bytes(color=(40, 120, 50)):
    output = BytesIO()
    Image.new("RGB", (8, 8), color).save(output, format="PNG")
    return output.getvalue()


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
    assert report["classification"]["method"] == "rule_based"
    assert "confidence" not in report["classification"]
    assert report["image_hash"] is None
    assert report["evidence_risk"]["authenticity_status"] == "not_verified"

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
    assert body["report"]["status"] == "submitted"
    assert body["task"]["status"] == "open"
    assert body["report"]["resolution_evidence"]["photo_url"] == resolve_payload["resolution_photo_url"]
    assert body["report"]["resolution_evidence"]["gps"] == resolve_payload["gps"]
    assert body["report"]["resolution_evidence"]["evidence_risk"]["authenticity_status"] == "not_verified"
    assert body["report"]["resolution_evidence"]["review_status"] == "pending"
    assert body["report"]["resolution_evidence"]["review_type"] == "manual_official_review"

    persisted = __import__("backend.db", fromlist=["Database"]).Database(storage_path=database.storage_path)
    assert persisted.get_report(report_id)["resolution_evidence"]["review_status"] == "pending"

    approval = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "approved"},
        headers={"Authorization": "Bearer official-officer-1"},
    )
    assert approval.status_code == 200, approval.text
    approved = approval.json()
    assert approved["report"]["status"] == "resolved"
    assert approved["task"]["status"] == "resolved"
    assert approved["report"]["resolution_evidence"]["review_status"] == "approved"
    assert approved["report"]["resolution_evidence"]["authenticity_status"] == "not_verified"

    duplicate_approval = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "approved"},
        headers={"Authorization": "Bearer official-officer-1"},
    )
    assert duplicate_approval.status_code == 409


def test_citizen_cannot_resolve_even_their_own_report():
    payload = {
        "title": "Overflowing civic bin",
        "description": "Waste is overflowing beside the public market entrance.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": "https://example.com/before.jpg",
        "citizen_id": "citizen-demo-1",
    }
    created = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})
    response = client.post(
        f"/api/v1/reports/{created.json()['id']}/resolve",
        json={
            "resolution_photo_url": "https://example.com/after.jpg",
            "gps": payload["gps"],
        },
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )

    assert response.status_code == 403


def test_citizen_cannot_approve_pending_resolution_evidence():
    payload = {
        "title": "Overflowing civic bin",
        "description": "Waste is overflowing beside the public market entrance.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": "https://example.com/before.jpg",
        "citizen_id": "citizen-demo-1",
    }
    created = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})
    report_id = created.json()["id"]
    submitted = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={"resolution_photo_url": "https://example.com/after.jpg", "gps": payload["gps"]},
        headers={"Authorization": "Bearer official-officer-1"},
    )
    approval = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "approved"},
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )

    assert submitted.status_code == 200
    assert approval.status_code == 403


def test_rejected_resolution_stays_open_and_can_be_resubmitted():
    payload = {
        "title": "Blocked storm drain",
        "description": "The storm drain is blocked and needs municipal attention.",
        "category": "drainage",
        "gps": {"latitude": 19.0800, "longitude": 72.8800},
        "photo_url": "https://example.com/drain-before.jpg",
        "citizen_id": "citizen-demo-1",
    }
    created = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})
    report_id = created.json()["id"]
    headers = {"Authorization": "Bearer official-officer-1"}
    first_submission = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={"resolution_photo_url": "https://example.com/drain-after-1.jpg", "gps": payload["gps"]},
        headers=headers,
    )
    no_reason = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "rejected"},
        headers=headers,
    )
    rejected = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "rejected", "reason": "The drain remains blocked in the submitted image."},
        headers=headers,
    )

    assert first_submission.status_code == 200
    assert no_reason.status_code == 422
    assert rejected.status_code == 200
    rejection_body = rejected.json()
    assert rejection_body["report"]["status"] == "submitted"
    assert rejection_body["task"]["status"] == "open"
    assert rejection_body["report"]["resolution_evidence"]["review_status"] == "rejected"
    assert rejection_body["report"]["resolution_evidence"]["authenticity_status"] == "not_verified"
    assert rejection_body["report"]["resolution_evidence"]["rejection_reason"]

    duplicate_rejection = client.post(
        f"/api/v1/reports/{report_id}/resolution-evidence/verify",
        json={"decision": "rejected", "reason": "duplicate"},
        headers=headers,
    )
    second_submission = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={"resolution_photo_url": "https://example.com/drain-after-2.jpg", "gps": payload["gps"]},
        headers=headers,
    )
    assert duplicate_rejection.status_code == 409
    assert second_submission.status_code == 200
    assert second_submission.json()["report"]["resolution_evidence"]["review_status"] == "pending"


def test_resolution_requires_new_image_reference_and_nearby_gps():
    payload = {
        "title": "Overflowing civic bin",
        "description": "Waste is overflowing beside the public market entrance.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": "https://example.com/before.jpg",
        "citizen_id": "citizen-demo-1",
    }
    created = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})
    report_id = created.json()["id"]

    same_photo = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={"resolution_photo_url": payload["photo_url"], "gps": payload["gps"]},
        headers={"Authorization": "Bearer official-officer-1"},
    )
    distant_photo = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={
            "resolution_photo_url": "https://example.com/after.jpg",
            "gps": {"latitude": payload["gps"]["latitude"] + 0.00046, "longitude": payload["gps"]["longitude"]},
        },
        headers={"Authorization": "Bearer official-officer-1"},
    )
    insecure_photo = client.post(
        f"/api/v1/reports/{report_id}/resolve",
        json={
            "resolution_photo_url": "http://example.com/after.jpg",
            "gps": payload["gps"],
        },
        headers={"Authorization": "Bearer official-officer-1"},
    )

    assert same_photo.status_code == 400
    assert "different from the original" in same_photo.json()["error"]
    assert distant_photo.status_code == 400
    assert "within 50 meters" in distant_photo.json()["error"]
    assert insecure_photo.status_code == 400
    assert "must use HTTPS" in insecure_photo.json()["error"]


def test_dashboard_is_restricted_to_official_roles():
    response = client.get("/api/v1/dashboard", headers={"Authorization": "Bearer citizen-demo-1"})

    assert response.status_code == 403


def test_reused_and_insecure_image_references_are_high_risk():
    payload = {
        "title": "Unsecured waste evidence",
        "description": "Waste has accumulated beside the bus stop and needs collection.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": "http://example.com/bin.jpg?signature=original",
        "citizen_id": "citizen-demo-1",
    }
    first = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})
    payload["photo_url"] = "http://example.com/bin.jpg?signature=rotated"
    second = client.post("/api/v1/reports", json=payload, headers={"Authorization": "Bearer citizen-citizen-demo-1"})

    assert first.status_code == 201
    assert first.json()["evidence_risk"]["authenticity_status"] == "not_verified"
    assert second.json()["evidence_risk"]["risk_level"] == "high"
    assert "image_reference_reused" in second.json()["evidence_risk"]["signals"]
    assert "insecure_image_transport" in first.json()["evidence_risk"]["signals"]


def test_upload_presign_is_explicitly_unavailable_without_storage_integration():
    response = client.post("/api/v1/uploads/presign", headers={"Authorization": "Bearer citizen-citizen-demo-1"})

    assert response.status_code == 501


def test_local_image_upload_validates_content_and_serves_privately():
    headers = {"Authorization": "Bearer citizen-citizen-demo-1"}
    uploaded = client.post(
        "/api/v1/uploads",
        files={"file": ("evidence.png", _png_bytes(), "image/png")},
        headers=headers,
    )
    assert uploaded.status_code == 201, uploaded.text
    evidence = uploaded.json()
    assert evidence["content_sha256"]
    assert evidence["authenticity_status"] == "not_verified"
    assert evidence["photo_url"].endswith(".png")
    assert (database.storage_path.parent / "evidence" / f"{evidence['evidence_id']}.png").stat().st_mode & 0o077 == 0

    retrieved = client.get(evidence["photo_url"], headers=headers)
    denied = client.get(evidence["photo_url"], headers={"Authorization": "Bearer citizen-other-user"})
    assert retrieved.status_code == 200
    assert retrieved.content == _png_bytes()
    assert retrieved.headers["cache-control"] == "private, no-store"
    assert denied.status_code == 403


def test_image_upload_rejects_invalid_content_and_mime_mismatch():
    headers = {"Authorization": "Bearer citizen-citizen-demo-1"}
    invalid = client.post(
        "/api/v1/uploads",
        files={"file": ("fake.png", b"not an image", "image/png")},
        headers=headers,
    )
    wrong_mime = client.post(
        "/api/v1/uploads",
        files={"file": ("wrong.jpg", _png_bytes(), "image/jpeg")},
        headers=headers,
    )

    assert invalid.status_code == 415
    assert wrong_mime.status_code == 415


def test_upload_rejects_oversized_image(monkeypatch):
    from backend import routes

    settings = Settings(environment="test", demo_auth_enabled=True, max_upload_size_mb=1, _env_file=None)
    monkeypatch.setattr(routes, "get_settings", lambda: settings)
    oversized = client.post(
        "/api/v1/uploads",
        files={"file": ("large.png", _png_bytes() + b"\x00" * (1024 * 1024), "image/png")},
        headers={"Authorization": "Bearer citizen-citizen-demo-1"},
    )

    assert oversized.status_code == 413


def test_uploaded_image_content_hash_detects_exact_reuse():
    headers = {"Authorization": "Bearer citizen-citizen-demo-1"}
    image_bytes = _png_bytes()
    before = client.post("/api/v1/uploads", files={"file": ("before.png", image_bytes, "image/png")}, headers=headers).json()
    reused = client.post("/api/v1/uploads", files={"file": ("reused.png", image_bytes, "image/png")}, headers=headers).json()
    report_body = {
        "title": "Overflowing bin near square",
        "description": "Overflowing garbage requires collection at this location.",
        "category": "waste",
        "gps": {"latitude": 19.0760, "longitude": 72.8777},
        "photo_url": before["photo_url"],
    }
    first = client.post("/api/v1/reports", json=report_body, headers=headers)
    report_body.update(
        {
            "title": "Repeated image evidence report",
            "gps": {"latitude": 19.0780, "longitude": 72.8800},
            "photo_url": reused["photo_url"],
        }
    )
    second = client.post("/api/v1/reports", json=report_body, headers=headers)

    assert first.status_code == 201
    assert first.json()["image_hash"] == before["content_sha256"]
    assert first.json()["image_hash_kind"] == "sha256_content"
    assert second.status_code == 201
    assert second.json()["duplicate_of"] == first.json()["id"]
    assert "exact_image_content_reused" in second.json()["evidence_risk"]["signals"]
    assert second.json()["evidence_risk"]["authenticity_status"] == "not_verified"


def test_upload_metadata_persists_with_image_file(tmp_path):
    from backend.db import Database
    from backend.services import CivicPulseService
    from backend.security import AuthUser

    db = Database(storage_path=tmp_path / "db.json")
    service_for_test = CivicPulseService(db)
    evidence = service_for_test.store_uploaded_evidence(_png_bytes(), "image/png", AuthUser(user_id="citizen-1"))
    restored = Database(storage_path=tmp_path / "db.json")

    assert restored.get_evidence(evidence["evidence_id"])["content_sha256"] == evidence["content_sha256"]
    assert service_for_test.uploaded_evidence_path(evidence).read_bytes() == _png_bytes()


def test_department_role_alias_works_with_demo_auth():
    response = client.get(
        "/api/v1/dashboard",
        headers={"Authorization": "Bearer department-ops"},
    )
    assert response.status_code == 200
    assert response.json()["total_reports"] == 0


def test_database_persists_reports_to_disk(tmp_path):
    from backend.db import Database

    storage_path = tmp_path / "civicpulse.json"
    db = Database(storage_path=storage_path)
    report = {
        "id": "report_persisted_1",
        "title": "Persisted report",
        "description": "Stored to disk for restart resilience",
        "category": "waste",
        "gps": {"latitude": 12.9, "longitude": 77.5},
        "photo_url": "https://example.com/persisted.jpg",
        "citizen_id": "citizen-demo-2",
        "status": "submitted",
    }

    db.create_report(report)
    reloaded = Database(storage_path=storage_path)

    assert reloaded.get_report("report_persisted_1")["title"] == "Persisted report"
