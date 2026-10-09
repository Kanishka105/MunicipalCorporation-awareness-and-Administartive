# MunicipalCorporation-awareness-and-Administartive

CivicPulse is a compact FastAPI backend for a municipal civic issue reporting and operations platform. It supports report intake, task assignment, duplicate detection, role-aware access checks, and dashboard summaries for civic workflows.

## Features
- Report creation and validation
- Role-based access for citizens and municipal officials
- Duplicate detection by photo hash and geographic proximity
- Report task workflow and resolution validation
- Health and readiness endpoints for local deployment checks

## Local setup
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

## Run tests
```bash
pytest -q
```

## Notes
This project is implemented as a local-first prototype and keeps AWS-specific integrations as configuration points rather than a live cloud deployment.
