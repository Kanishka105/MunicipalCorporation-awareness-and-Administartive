<div align="center">
  <h1>CivicPulse Enterprise</h1>
  <h3>Delhi Municipal Corporation Civic Hazard Intelligence Platform</h3>
</div>

---

**CivicPulse** is an enterprise-grade civic management and automated hazard triage platform. Designed for the Delhi Municipal Corporation, it bridges the gap between citizens, AI diagnostic systems, field operators, and municipal executives through a real-time, 4-Swimlane Architectural Pipeline.

The system strictly enforces authenticity via hardware-level GPS locking, EXIF timestamp signatures, and perceptual hashing to prevent fabricated reports, ensuring municipal resources are allocated with precision.

---

## 🏛️ Core Architecture & Innovations

CivicPulse operates on a sophisticated, multi-tiered state machine designed to automate triage and accelerate Service Level Agreement (SLA) compliance.

1. **Anti-Fraud Telemetry & Live Camera Enforcement**
   - Implements strict OS-level restrictions blocking gallery uploads.
   - Requires live camera captures with embedded EXIF GPS coordinates.
   - Computes 64-bit DCT perceptual hashes (pHash) against incoming media to reject recycled or forged submissions within a 120s buffer window.

2. **Proximity-Based Clustering & Ticket Merge**
   - Ingests geolocation parameters (Lat/Lng).
   - Executes 50-meter radius proximity checks against active, unresolved tickets.
   - Instead of polluting the system with duplicate tickets, nearby reports automatically merge as "Community Upvotes," crediting the citizen with +10 Karma Points and amplifying the ticket's priority weighting.

3. **AI-Driven Visual Diagnostics (AWS Rekognition Integration)**
   - Analyzes imagery for specific tags: *Garbage Dumps, Overflowing Bins, Silt, Construction Debris*.
   - Calculates a severity index (0–100), dynamically injecting higher multipliers if the coordinates are in proximity to mapped school zones or hospitals.
   - Post-resolution, enforces a strict Before/After Visual Difference Engine check (requiring a structural difference score of ≥ 85%) before formally closing the SLA loop.

4. **Automated SLA Escalation Matrix**
   - Active tasks strictly monitor a 45-minute SLA countdown timer.
   - Breaching the 75% time threshold triggers automated escalation subroutines, routing push notifications directly to the Zonal Inspector and Municipal Commissioner pipelines.

---

## ⚙️ 4-Swimlane System Design Workflow

The architecture is explicitly segregated into four autonomous execution lanes:

### 1. Citizen Lane (Edge Capture)
- **MFA Authentication**: Password-less 6-digit OTP login (+91 formatting) mapping to Cognito session tokens.
- **Incident Capture**: Live photo submission triggering the pipeline.
- **Ledger & Rewards**: 5-step status timeline (`Reported ➔ Assigned ➔ In Progress ➔ Resolved ➔ Verified`). Successful verification yields +25 Karma Points redeemable for DTC / Delhi Metro transit passes.

### 2. System + AI Lane (Triage Engine)
- **Validation**: pHash duplicate check + Rekognition object tagging.
- **Clustering**: Proximity merge and SLA clock instantiation.
- **Resolution Verification**: Evaluates field-worker "after-photos" utilizing structural visual diff algorithms.

### 3. Field Worker Lane (Execution)
- **Push Telemetry**: Receives prioritized, SLA-sorted task queues via FCM.
- **Geofenced Resolution**: Workers must geographically lock within a 50m radius of the reported node to unlock the "Resolution Camera" capability.

### 4. Executive Officers Lane (Command & Control)
- **Escalation Monitor**: Captures breached SLA alarms.
- **Predictive GIS Heatmaps**: Synthesizes live localized ward data into MapLibre thermal intensity maps.
- **Bedrock AI Copilot**: Amazon Bedrock (Claude 3) dynamically parses unstructured hazard data to generate Executive Root-Cause Briefs and automated compactor dispatch strategies.

---

## 📂 Project Folder Structure

```text
MunicipalCorporation-awareness-and-Administartive/
├── app/                                 # Primary Flutter Application Root
│   ├── pubspec.yaml                     # Dependencies & Asset configuration
│   └── lib/
│       ├── main.dart                    # Application Entrypoint & Shell Routing
│       ├── models/                      # Immutable Data Entities
│       │   ├── copilot_model.dart       # AWS Bedrock/Claude response definitions
│       │   ├── executive_dashboard.dart # Dashboard metrics & KPI models
│       │   ├── hazard_model.dart        # Incident structures & Radar mapping
│       │   ├── officer_task_model.dart  # SLA task queues & geofence metadata
│       │   └── user_model.dart          # Citizen & Employee RBAC structures
│       ├── providers/
│       │   └── civic_app_state.dart     # Global State Management & Core Business Logic
│       ├── screens/                     # Primary Navigational Views
│       │   ├── copilot_screen.dart      # Executive Bedrock AI Chat interface
│       │   ├── executive_dashboard.dart # KPI & Manual Review Queue
│       │   ├── feed_screen.dart         # Citizen Feed & Hazard Radar
│       │   ├── login_screen.dart        # MFA Authentication Portal
│       │   ├── report_hazard_modal.dart # Live Camera Incident Capture
│       │   └── tasks_screen.dart        # Worker SLA Queue & Geofence Validator
│       ├── services/
│       │   ├── civic_storage_service.dart # Local SharedPreferences persistence
│       │   └── localization_service.dart  # EN/HI Dynamic Translation Dictionary
│       ├── theme/
│       │   └── app_theme.dart           # Design System (Colors, Typography, Dark/Light mode)
│       └── widgets/
│           ├── bottom_nav_bar.dart      # Persistent Role-Based Navigation
│           ├── system_workflow_sheet.dart # Interactive 4-Lane Architecture Tracker
│           └── top_header.dart          # Global AppBar & Quick Actions
```

---

## 🚀 Installation & Operation

### Prerequisites
- **Flutter SDK**: `^3.41.6` (or latest stable)
- **Dart SDK**: `^3.7.0`
- **Chrome** (for web deployment visualization)

### Build Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Kanishka105/MunicipalCorporation-awareness-and-Administartive.git
   cd MunicipalCorporation-awareness-and-Administartive/app
   ```

2. **Fetch Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Development Server**
   To execute the application utilizing the Chrome web renderer on port 3000:
   ```bash
   flutter run -d chrome --web-port 3000
   ```

4. **Test the Workflow**
   Once initialized, open `http://localhost:3000`. Navigate to the **"System Architecture Workflow"** via the top-right tree icon (`Icons.account_tree`) or the Feed Screen Banner to initiate the interactive pipeline simulation.

---

<div align="center">
  <i>Developed for optimized urban governance and predictive civic maintenance.</i>
</div>
