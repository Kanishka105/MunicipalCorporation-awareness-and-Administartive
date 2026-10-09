import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/hazard_model.dart';
import '../models/officer_task_model.dart';
import '../models/copilot_model.dart';
import '../models/leaderboard_model.dart';
import '../models/executive_dashboard_model.dart';
import '../services/civic_storage_service.dart';
import '../services/localization_service.dart';

class CivicAppState extends ChangeNotifier {
  final CivicStorageService _storage = CivicStorageService();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  String _language = 'en'; // 'en' or 'hi'
  String get language => _language;

  String tr(String key) => AppLocalization.get(key, _language);

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  ActiveSubmissionModel? _activeSubmission;
  ActiveSubmissionModel? get activeSubmission => _activeSubmission;

  List<HazardRadarModel> _hazards = [];
  List<HazardRadarModel> get hazards => _hazards;

  UrgentOfficerTaskModel? _urgentTask;
  UrgentOfficerTaskModel? get urgentTask => _urgentTask;

  List<CompletedTaskModel> _completedTasks = [];
  List<CompletedTaskModel> get completedTasks => _completedTasks;

  List<HotspotLedgerItemModel> _hotspots = [];
  List<HotspotLedgerItemModel> get hotspots => _hotspots;

  List<CopilotChatMessage> _copilotMessages = [];
  List<CopilotChatMessage> get copilotMessages => _copilotMessages;

  // Leaderboard & Citizen Fixes
  List<CitizenLeaderboardEntry> _leaderboard = [];
  List<CitizenLeaderboardEntry> get leaderboard => _leaderboard;

  List<CitizenFixSuggestion> _fixSuggestions = [];
  List<CitizenFixSuggestion> get fixSuggestions => _fixSuggestions;

  // Executive Dashboard & Low Confidence Review Queue
  UserRole _dashboardRole = UserRole.zonalInspector;
  UserRole get dashboardRole => _dashboardRole;

  List<LowConfidenceReviewItem> _reviewQueue = [];
  List<LowConfidenceReviewItem> get reviewQueue => _reviewQueue;

  List<ColdZoneInspectionItem> _coldZones = [];
  List<ColdZoneInspectionItem> get coldZones => _coldZones;

  List<WardPerformanceComparison> _wardComparisons = [];
  List<WardPerformanceComparison> get wardComparisons => _wardComparisons;

  bool _isAutoDispatched = false;
  bool get isAutoDispatched => _isAutoDispatched;

  bool _isPwdApproved = false;
  bool get isPwdApproved => _isPwdApproved;

  // Real-time SLA timer & 75% Escalation Tracker
  Timer? _slaTimer;
  int _urgentSlaRemainingSeconds = 1680; // 28m 00s
  int get urgentSlaRemainingSeconds => _urgentSlaRemainingSeconds;
  String _escalationStatus = 'Escalated to Field Unit #3';
  String get escalationStatus => _escalationStatus;

  // Tamper proof form state
  final double _geofenceDistance = 6.4;
  double get geofenceDistance => _geofenceDistance;
  String? _capturedProofImage;
  String? get capturedProofImage => _capturedProofImage;
  String _selectedDisposalLog = 'Desilting completed, waste loaded in Compactor DL-1GC-4921';
  String get selectedDisposalLog => _selectedDisposalLog;
  bool _isSubmittingProof = false;
  bool get isSubmittingProof => _isSubmittingProof;

  CivicAppState() {
    _initApp();
  }

  Future<void> _initApp() async {
    // Load theme
    final isDark = await _storage.loadThemeMode();
    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    // Load user
    final savedUser = await _storage.loadUser();
    if (savedUser != null) {
      _currentUser = savedUser;
    } else {
      _currentUser = const UserModel(
        id: 'usr_del_4201',
        name: 'Aarav Sharma',
        phone: '+91 98765 43210',
        email: 'aarav.sharma@dtu.ac.in',
        ward: 'DTU Ward 42',
        role: UserRole.citizen,
        karmaPoints: 340,
        streakDays: 7,
        trustScore: 98.4,
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
        cognitoGroup: 'MCD-Citizen-Verified',
      );
    }

    // Load active submission
    final savedSub = await _storage.loadActiveSubmission();
    _activeSubmission = savedSub ??
        const ActiveSubmissionModel(
          id: 'sub_8840',
          ticketCode: 'CP-DEL-8840',
          title: 'Cracked Concrete Manhole Cover',
          location: 'Pocket 2, Sector 17 Rohini • Submitted 3h ago',
          timeAgo: 'Submitted 3h ago',
          status: 'Crew En Route',
          statusColor: 'mint',
          steps: [
            ActiveSubmissionStep(
              title: 'Reported',
              subtitle: '08:15 AM',
              isCompleted: true,
              isCurrent: false,
              iconType: 'check',
            ),
            ActiveSubmissionStep(
              title: 'Assigned',
              subtitle: 'Unit #12',
              isCompleted: true,
              isCurrent: false,
              iconType: 'dedup',
            ),
            ActiveSubmissionStep(
              title: 'In Progress',
              subtitle: 'En Route',
              isCompleted: true,
              isCurrent: false,
              iconType: 'dispatch',
            ),
            ActiveSubmissionStep(
              title: 'Resolved',
              subtitle: 'Pending Proof',
              isCompleted: false,
              isCurrent: true,
              iconType: 'pending',
            ),
            ActiveSubmissionStep(
              title: 'Verified',
              subtitle: 'Zonal SE',
              isCompleted: false,
              isCurrent: false,
              iconType: 'pending',
            ),
          ],
          securityLockText: 'Tamper-safe GPS camera lock applied',
          liveSlaUrl: 'https://civicpulse.delhi.gov.in/sla/8840',
        );

    // Load hazards
    final savedHazards = await _storage.loadHazards();
    _hazards = savedHazards ??
        [
          HazardRadarModel(
            id: 'hz_8921',
            ticketCode: 'CP-DEL-8921',
            title: 'Severe Overflowing Dumpster at DTU North Gate',
            description:
                'Municipal container over capacity by 200%. Proximity to DTU Campus entrance. High footfall obstruction.',
            locationTag: 'DTU North Gate • Node #DTU-042',
            nodeCode: '#DTU-042',
            aiTag: 'Rekognition: Solid Waste (98.4%)',
            badgeTag: '• Urgent SLA',
            isUrgent: true,
            backers: 148,
            backerSubtext: '+12 in last hour',
            slaTimeLeft: '1h 42m Left',
            slaSubtext: 'Field Triage SLA',
            imageUrl: 'https://images.unsplash.com/photo-1605600659908-0ef719419d41?auto=format&fit=crop&w=800&q=80',
            hasSupported: false,
            createdAt: DateTime.now().subtract(const Duration(minutes: 50)),
          ),
          HazardRadarModel(
            id: 'hz_9014',
            ticketCode: 'CP-DEL-9014',
            title: 'Stormwater Drain Silt & Plastic Clogging',
            description:
                'Runoff backflow risk detected before upcoming rainfall near Dr. BSA Hospital approach road.',
            locationTag: 'Rohini Sec-17 Road 3 • Node #ROH-19',
            nodeCode: '#ROH-19',
            aiTag: 'Rekognition: Silt Clog (94%)',
            badgeTag: 'Sanitation Unit #4',
            isUrgent: false,
            backers: 42,
            backerSubtext: 'Hospital Zone (High Priority)',
            slaTimeLeft: 'In Progress',
            slaSubtext: 'ETA: Today 4:00 PM',
            imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&fit=crop&w=800&q=80',
            hasSupported: false,
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          ),
        ];

    // Load urgent task
    final savedTask = await _storage.loadUrgentTask();
    _urgentTask = savedTask ??
        const UrgentOfficerTaskModel(
          taskId: '#TSK-881',
          departmentTag: 'PWD Sanitation',
          title: 'Shahbad Main Drain Desilting & Overflow Clearance',
          locationName: 'Sector 17 Ring Rd (Near Metro Pillar 24)',
          gpsCoordinates: '28.7499° N, 77.1172° E',
          distanceAway: '120m away from current spot',
          aiRekognitionLabel: 'Drain Clog',
          aiConfidence: '98.4%',
          reportedTime: 'Reported 42m',
          citizenTicket: '#CIT-29019',
          originalProofUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&fit=crop&w=800&q=80',
          slaRemaining: Duration(minutes: 28),
        );

    // Completed tasks
    final savedCompleted = await _storage.loadCompletedTasks();
    _completedTasks = savedCompleted ??
        const [
          CompletedTaskModel(
            taskId: '#TSK-879',
            aiDiffPercent: 'AI Diff: 96% Cleared',
            completionTime: '12:35 PM',
            title: 'DTU Gate 1 Road Debris Removal',
            beforeImageUrl: 'https://images.unsplash.com/photo-1530587191325-3db32d826c18?auto=format&fit=crop&w=400&q=80',
            afterImageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&w=400&q=80',
            citizenLabel: 'Citizen Upload (EXIF Locked)',
            officerProofLabel: 'Field Proof RK-Unit#3',
            triageScore: 0.98,
            supervisorStatus: 'Officer Sunita Verma (Zonal SE) Pending Signature',
          ),
        ];

    // Hotspots
    final savedHotspots = await _storage.loadHotspots();
    _hotspots = savedHotspots ??
        const [
          HotspotLedgerItemModel(
            id: 'hs_bawana',
            title: 'Bawana Road Culvert Drainage',
            badgeText: '3 Recurring Silt Runs',
            locationSubtext: 'Sector 17 Junction • Chainage 4+200',
            scheduleTitle: 'Scheduled: Preventive Dredging Cycle',
            scheduleEta: 'T-Minus 48h',
            telemetryText: 'Bedrock Sensor Telemetry: 74% Culvert Choke',
            actionButtonText: 'Force Task Crew →',
            isDispatched: false,
          ),
          HotspotLedgerItemModel(
            id: 'hs_sec16',
            title: 'Sector 16 Outer Ring Road',
            badgeText: '89% AI Refailure Prob.',
            locationSubtext: 'Poles #42-A through #58-C',
            scheduleTitle: 'Ballast Heat Cycle Breakdown Pattern',
            scheduleEta: 'Replace 12 Units',
            telemetryText: 'Preventive Requisition: ₹42,000 Inventory Ready',
            actionButtonText: 'Queue Dispatcher →',
            isDispatched: false,
          ),
        ];

    // Initialize Leaderboard
    _leaderboard = const [
      CitizenLeaderboardEntry(
        rank: 1,
        name: 'Aarav Sharma (You)',
        ward: 'Ward 42 Rohini',
        karmaPoints: 340,
        verifiedReports: 14,
        trustScore: 98.4,
        badge: 'Civic Guardian 🛡️',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
      ),
      CitizenLeaderboardEntry(
        rank: 2,
        name: 'Priya Verma',
        ward: 'Ward 42 DTU Sector',
        karmaPoints: 310,
        verifiedReports: 12,
        trustScore: 97.8,
        badge: 'Sanitation Champion 🌟',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80',
      ),
      CitizenLeaderboardEntry(
        rank: 3,
        name: 'Rohit Sen',
        ward: 'Ward 42 Sector 16',
        karmaPoints: 280,
        verifiedReports: 10,
        trustScore: 96.5,
        badge: 'Green Warden 🌿',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
      ),
      CitizenLeaderboardEntry(
        rank: 4,
        name: 'Meera Deshmukh',
        ward: 'Ward 42 Shahbad',
        karmaPoints: 240,
        verifiedReports: 8,
        trustScore: 95.0,
        badge: 'Civic Scout 🔍',
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
      ),
    ];

    // Fix suggestions
    _fixSuggestions = [
      CitizenFixSuggestion(
        id: 'fix_1',
        ticketCode: 'CP-DEL-8921',
        citizenName: 'Aarav Sharma',
        suggestionText: 'Install 2 additional high-capacity 2.4m³ compactor bins at DTU North Gate student exit.',
        upvotes: 24,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        hasUpvoted: true,
      ),
      CitizenFixSuggestion(
        id: 'fix_2',
        ticketCode: 'CP-DEL-9014',
        citizenName: 'Dr. Neha Rao',
        suggestionText: 'Install heavy-duty silt catchment mesh before monsoon culvert entry.',
        upvotes: 18,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        hasUpvoted: false,
      ),
    ];

    // Low Confidence Review Queue
    _reviewQueue = [
      LowConfidenceReviewItem(
        id: 'rev_1',
        ticketCode: 'CP-DEL-8940',
        title: 'Possible waste burning at Bawana border',
        ward: 'Ward 42 Rohini',
        aiConfidence: 64.2,
        flagReason: 'Low-light EXIF capture • pHash similarity 78% to generic campfire',
        detectedCategory: 'Waste Burning & Smoke Detection',
        imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&fit=crop&w=600&q=80',
        pHashScore: '0x8f2a110b',
        citizenMaskedPhone: '+91 98*** **412',
        severityScore: 82,
        isNearSensitiveZone: true,
        sensitiveZoneName: 'Bawana Nature Water Body',
      ),
      LowConfidenceReviewItem(
        id: 'rev_2',
        ticketCode: 'CP-DEL-8955',
        title: 'Loose construction debris on Sector 17 flyover',
        ward: 'Ward 42 Rohini',
        aiConfidence: 68.8,
        flagReason: 'Partial occlusion by moving vehicular traffic',
        detectedCategory: 'Construction & Demolition Debris',
        imageUrl: 'https://images.unsplash.com/photo-1530587191325-3db32d826c18?auto=format&fit=crop&w=600&q=80',
        pHashScore: '0x3c99e4f0',
        citizenMaskedPhone: '+91 94*** **908',
        severityScore: 74,
        isNearSensitiveZone: false,
        sensitiveZoneName: '',
      ),
    ];

    // Cold zones
    _coldZones = const [
      ColdZoneInspectionItem(
        zoneId: 'cz_1',
        name: 'Sector 17 Block D Corridor',
        ward: 'Ward 42',
        daysWithoutReport: '14 Days',
        riskFactor: 'High monsoon backflow vulnerability',
        suggestedAction: 'Deploy motorized inspection squad with GPS scanner',
      ),
      ColdZoneInspectionItem(
        zoneId: 'cz_2',
        name: 'Shahbad Extension Industrial Pocket 3',
        ward: 'Ward 42',
        daysWithoutReport: '18 Days',
        riskFactor: 'Unmonitored night construction debris dumping',
        suggestedAction: 'Route CCTV pole telemetry inspection pass',
      ),
    ];

    // Ward performance comparison
    _wardComparisons = const [
      WardPerformanceComparison(
        wardName: 'Ward 42 (Rohini - DTU)',
        openComplaints: 3,
        slaMisses: 0,
        clearanceRatePct: 96.4,
        citizenTrustAvg: 98.4,
        activeSquads: 4,
        escalationLevel: 'Normal (Unit #3 on duty)',
      ),
      WardPerformanceComparison(
        wardName: 'Ward 7 (Civil Lines)',
        openComplaints: 18,
        slaMisses: 12,
        clearanceRatePct: 68.2,
        citizenTrustAvg: 89.1,
        activeSquads: 2,
        escalationLevel: 'Level 2 Escalated (Zonal Officer Brief)',
      ),
      WardPerformanceComparison(
        wardName: 'Ward 18 (Dwarka Sector 9)',
        openComplaints: 7,
        slaMisses: 1,
        clearanceRatePct: 91.0,
        citizenTrustAvg: 94.5,
        activeSquads: 3,
        escalationLevel: 'Level 1 (Inspector Alert)',
      ),
      WardPerformanceComparison(
        wardName: 'Ward 31 (Karol Bagh)',
        openComplaints: 14,
        slaMisses: 5,
        clearanceRatePct: 79.4,
        citizenTrustAvg: 91.2,
        activeSquads: 3,
        escalationLevel: 'Level 2 (Zonal SE Review)',
      ),
    ];

    _startSlaTimer();
    _isInitialized = true;
    notifyListeners();
  }

  void toggleLanguage() {
    _language = _language == 'en' ? 'hi' : 'en';
    notifyListeners();
  }

  void _startSlaTimer() {
    _slaTimer?.cancel();
    _slaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_urgentSlaRemainingSeconds > 0) {
        _urgentSlaRemainingSeconds--;
        if (_urgentSlaRemainingSeconds < 420) {
          _escalationStatus = 'Level 2 Escalation: Zonal Officer Alert Sent (75% SLA Passed)';
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _slaTimer?.cancel();
    super.dispose();
  }

  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  void setDashboardRole(UserRole role) {
    _dashboardRole = role;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    _storage.saveThemeMode(_themeMode == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> loginAs({
    required UserRole role,
    required String name,
    required String phone,
    String? unitId,
  }) async {
    if (role == UserRole.fieldOfficer) {
      _currentUser = UserModel(
        id: 'usr_off_rk03',
        name: name.isNotEmpty ? name : 'Rajesh Kumar',
        phone: phone.isNotEmpty ? phone : '+91 94123 78901',
        email: 'rajesh.kumar@mcd.gov.in',
        ward: 'DTU Ward 42',
        role: UserRole.fieldOfficer,
        unitId: unitId ?? 'Unit #3',
        awsRegion: 'ap-south-1 (Mumbai)',
        gpsAccuracy: 1.8,
        assignedTasks: 4,
        clearedTasks: 2,
        criticalTasks: 1,
        rating: 4.9,
        avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
        cognitoGroup: 'MCD-Field-Officers',
        mfaVerified: true,
      );
      _currentNavIndex = 1;
    } else if (role == UserRole.zonalInspector || role == UserRole.commissioner || role == UserRole.stateAdmin) {
      _currentUser = UserModel(
        id: 'usr_sup_sv42',
        name: name.isNotEmpty ? name : 'Sunita Verma',
        phone: phone.isNotEmpty ? phone : '+91 98111 22334',
        email: 'sunita.verma@pwd.delhi.gov.in',
        ward: 'DTU Ward 42',
        role: role,
        unitId: 'Zonal SE #42',
        assignedTasks: 18,
        clearedTasks: 15,
        criticalTasks: 3,
        rating: 4.95,
        avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
        cognitoGroup: role == UserRole.commissioner ? 'MCD-Commissioners-Apex' : 'MCD-Zonal-Officers',
        mfaVerified: true,
      );
      _dashboardRole = role;
      _currentNavIndex = 4; // Executive Dashboard
    } else {
      _currentUser = UserModel(
        id: 'usr_del_4201',
        name: name.isNotEmpty ? name : 'Aarav Sharma',
        phone: phone.isNotEmpty ? phone : '+91 98765 43210',
        email: 'aarav.sharma@dtu.ac.in',
        ward: 'DTU Ward 42',
        role: UserRole.citizen,
        karmaPoints: 340,
        streakDays: 7,
        trustScore: 98.4,
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
        cognitoGroup: 'MCD-Citizen-Verified',
      );
      _currentNavIndex = 0;
    }

    await _storage.saveUser(_currentUser!);
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.clearUser();
    notifyListeners();
  }

  // Support / Back an issue
  Future<void> supportHazard(String hazardId) async {
    final index = _hazards.indexWhere((h) => h.id == hazardId);
    if (index != -1) {
      final hazard = _hazards[index];
      final newSupported = !hazard.hasSupported;
      final newBackers = newSupported ? hazard.backers + 1 : hazard.backers - 1;

      _hazards[index] = hazard.copyWith(
        hasSupported: newSupported,
        backers: newBackers,
      );

      if (newSupported && _currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          karmaPoints: _currentUser!.karmaPoints + 10,
        );
        await _storage.saveUser(_currentUser!);
      }

      await _storage.saveHazards(_hazards);
      notifyListeners();
    }
  }

  // Suggest a fix on a complaint
  void addFixSuggestion(String ticketCode, String text) {
    if (text.trim().isEmpty) return;
    final newFix = CitizenFixSuggestion(
      id: 'fix_${DateTime.now().millisecondsSinceEpoch}',
      ticketCode: ticketCode,
      citizenName: _currentUser?.name ?? 'Aarav Sharma',
      suggestionText: text.trim(),
      upvotes: 1,
      createdAt: DateTime.now(),
      hasUpvoted: true,
    );

    _fixSuggestions.insert(0, newFix);
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        karmaPoints: _currentUser!.karmaPoints + 15,
      );
      _storage.saveUser(_currentUser!);
    }
    notifyListeners();
  }

  void toggleUpvoteFix(String fixId) {
    final idx = _fixSuggestions.indexWhere((f) => f.id == fixId);
    if (idx != -1) {
      final item = _fixSuggestions[idx];
      final newUpvoted = !item.hasUpvoted;
      _fixSuggestions[idx] = item.copyWith(
        hasUpvoted: newUpvoted,
        upvotes: newUpvoted ? item.upvotes + 1 : item.upvotes - 1,
      );
      notifyListeners();
    }
  }

  // Redeem Karma Points for DTC passes
  bool redeemKarmaPoints(int pointsToRedeem) {
    if (_currentUser != null && _currentUser!.karmaPoints >= pointsToRedeem) {
      _currentUser = _currentUser!.copyWith(
        karmaPoints: _currentUser!.karmaPoints - pointsToRedeem,
      );
      _storage.saveUser(_currentUser!);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Duplicate Check & Severity Calculation for Report Submission
  Future<Map<String, dynamic>> submitNewHazardReport({
    required String title,
    required String description,
    required String category,
    required String locationTag,
    bool isNearHospitalOrSchool = true,
    String? customImageUrl,
  }) async {
    // Proximity Duplicate Merge Check (within 50m of DTU North Gate)
    if (locationTag.toLowerCase().contains('dtu north gate') || locationTag.toLowerCase().contains('dtu-042')) {
      // Merge with existing #CP-DEL-8921
      final index = _hazards.indexWhere((h) => h.ticketCode == 'CP-DEL-8921');
      if (index != -1) {
        _hazards[index] = _hazards[index].copyWith(
          backers: _hazards[index].backers + 1,
          hasSupported: true,
        );
        if (_currentUser != null) {
          _currentUser = _currentUser!.copyWith(
            karmaPoints: _currentUser!.karmaPoints + 10,
          );
          await _storage.saveUser(_currentUser!);
        }
        await _storage.saveHazards(_hazards);
        notifyListeners();
        return {
          'isDuplicateMerged': true,
          'ticketCode': 'CP-DEL-8921',
          'message': 'Duplicate detected within 50m of Node #DTU-042! Merged as Upvote & Boosted SLA (+10 KP).',
        };
      }
    }

    // Severity Calculation (0 to 100)
    int baseSeverity = 65;
    if (category.toLowerCase().contains('waste burning') || category.toLowerCase().contains('smoke')) {
      baseSeverity = 85;
    } else if (category.toLowerCase().contains('drain')) {
      baseSeverity = 75;
    }
    if (isNearHospitalOrSchool) {
      baseSeverity = (baseSeverity + 20).clamp(0, 100);
    }

    final newId = 'hz_${DateTime.now().millisecondsSinceEpoch}';
    final ticketCode = 'CP-DEL-${1000 + _hazards.length + 8922}';

    final newHazard = HazardRadarModel(
      id: newId,
      ticketCode: ticketCode,
      title: title,
      description: description,
      locationTag: locationTag,
      nodeCode: '#NODE-${DateTime.now().millisecond}',
      aiTag: 'Rekognition: $category (Severity $baseSeverity/100)',
      badgeTag: isNearHospitalOrSchool ? '• High Severity (Hospital/School)' : '• Just Reported',
      isUrgent: baseSeverity > 80,
      backers: 1,
      backerSubtext: 'Your verified live report',
      slaTimeLeft: '3h 30m Left',
      slaSubtext: 'AI Auto-Triage SLA',
      imageUrl: customImageUrl ?? 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&fit=crop&w=800&q=80',
      hasSupported: true,
      createdAt: DateTime.now(),
    );

    _hazards.insert(0, newHazard);

    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        karmaPoints: _currentUser!.karmaPoints + 25,
      );
      await _storage.saveUser(_currentUser!);
    }

    await _storage.saveHazards(_hazards);
    notifyListeners();
    return {
      'isDuplicateMerged': false,
      'ticketCode': ticketCode,
      'severity': baseSeverity,
      'message': 'Hazard dispatched with EXIF hash! +25 Karma Points added.',
    };
  }

  // Scan QR node & reward
  void backNodeFromQr(String nodeCode) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        karmaPoints: _currentUser!.karmaPoints + 10,
      );
      _storage.saveUser(_currentUser!);
      notifyListeners();
    }
  }

  // Field Officer Proof & Reopen Check
  void setCapturedProof(String imagePathOrUrl) {
    _capturedProofImage = imagePathOrUrl;
    notifyListeners();
  }

  void setSelectedDisposalLog(String log) {
    _selectedDisposalLog = log;
    notifyListeners();
  }

  Future<Map<String, dynamic>> submitResolutionProof({bool simulateIncomplete = false}) async {
    _isSubmittingProof = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1400));

    if (simulateIncomplete) {
      _isSubmittingProof = false;
      notifyListeners();
      return {
        'success': false,
        'aiDiffScore': 62.4,
        'message': 'AI Rekognition Diff Alert: 37.6% silt residue still detected! Task Reopened & Escalated to Inspector.',
      };
    }

    if (_urgentTask != null) {
      _urgentTask = _urgentTask!.copyWith(isResolved: true);
      await _storage.saveUrgentTask(_urgentTask!);

      final newCompleted = CompletedTaskModel(
        taskId: _urgentTask!.taskId,
        aiDiffPercent: 'AI Diff: 98% Cleared',
        completionTime: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period == DayPeriod.am ? 'AM' : 'PM'}',
        title: _urgentTask!.title,
        beforeImageUrl: _urgentTask!.originalProofUrl,
        afterImageUrl: _capturedProofImage ?? 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&w=400&q=80',
        citizenLabel: 'Citizen Upload (EXIF Locked)',
        officerProofLabel: 'Field Proof RK-Unit#3',
        triageScore: 0.99,
        supervisorStatus: 'Officer Sunita Verma (Zonal SE) Pending Signature',
      );

      _completedTasks.insert(0, newCompleted);
      await _storage.saveCompletedTasks(_completedTasks);

      if (_currentUser != null && _currentUser!.role == UserRole.fieldOfficer) {
        _currentUser = _currentUser!.copyWith(
          clearedTasks: _currentUser!.clearedTasks + 1,
          assignedTasks: _currentUser!.assignedTasks > 0 ? _currentUser!.assignedTasks - 1 : 0,
        );
        await _storage.saveUser(_currentUser!);
      }
    }

    _isSubmittingProof = false;
    _capturedProofImage = null;
    notifyListeners();
    return {
      'success': true,
      'aiDiffScore': 98.4,
      'message': 'Audit Passed! Cryptographic EXIF proof verified. Ticket marked Resolved.',
    };
  }

  // Officer Dashboard Review Queue Action
  void reviewItemAction(String reviewId, bool approve) {
    final idx = _reviewQueue.indexWhere((r) => r.id == reviewId);
    if (idx != -1) {
      _reviewQueue[idx].status = approve ? 'approved' : 'rejected';
      notifyListeners();
    }
  }

  // Copilot Actions
  void triggerAutoDispatch() {
    _isAutoDispatched = true;
    notifyListeners();
  }

  void approvePwdRouting() {
    _isPwdApproved = true;
    notifyListeners();
  }

  void dispatchHotspot(String hotspotId) {
    final index = _hotspots.indexWhere((h) => h.id == hotspotId);
    if (index != -1) {
      _hotspots[index] = _hotspots[index].copyWith(isDispatched: true);
      _storage.saveHotspots(_hotspots);
      notifyListeners();
    }
  }

  // Copilot Live Chat
  Future<void> sendCopilotQuery(String query) async {
    final userMsg = CopilotChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'user',
      text: query,
      timestamp: DateTime.now(),
    );

    _copilotMessages.add(userMsg);
    notifyListeners();

    final aiThinkingMsg = CopilotChatMessage(
      id: 'msg_ai_${DateTime.now().millisecondsSinceEpoch}',
      sender: 'bedrock',
      text: '...',
      timestamp: DateTime.now(),
      isGenerating: true,
    );
    _copilotMessages.add(aiThinkingMsg);
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 900));

    String aiResponse = '';
    final qLower = query.toLowerCase();

    if (qLower.contains('flood') || qLower.contains('sector 17')) {
      aiResponse =
          '**Bedrock Diagnostic Analysis for Sector 17 Flooding**:\n\n'
          '• **Primary Cause**: Stormwater drainage culvert at Bawana Rd chainage 4+200 has 74% silt accumulation.\n'
          '• **Inflow Rate**: Peak monsoon inflow exceeds 2.8m³/s against designed 1.2m³/s culvert clearance.\n'
          '• **Severity Score**: 94/100 (due to close proximity to Dr. BSA Hospital approach road).\n'
          '• **Recommendation**: Immediate deployment of suction compactor DL-1GC-4921 and hydro-jetting before upcoming 16:00 precipitation.';
    } else if (qLower.contains('brief') || qLower.contains('draft') || qLower.contains('miss')) {
      aiResponse =
          '**Bedrock Executive Brief (Ward 42 vs Regional Benchmarks)**:\n\n'
          '1. **Ward 42 Status**: 0 SLA misses this week. Clearance rate: 96.4%.\n'
          '2. **Regional Alerts**: 12 SLA misses in Ward 7 (Civil Lines) due to compactor shortage.\n'
          '3. **AI Action**: Recommended routing 2 reserve compactor units from Sector 16 depot to Ward 7.\n'
          '4. **Citizen Reliability**: Average Trust Score in Ward 42 is 98.4% with 0 fake EXIF attempts.';
    } else {
      aiResponse =
          '**Bedrock Claude 3 Municipal Engine**:\n\n'
          'Processed telemetry for **$query** across DTU Ward 42 GIS database (ap-south-1 Mumbai). '
          'SLA compliance is currently at 96.4% with 4 active field squads deployed. Preventive risk score is within baseline limits (0.34 low risk).';
    }

    _copilotMessages.removeLast();
    _copilotMessages.add(
      CopilotChatMessage(
        id: 'msg_ai_res_${DateTime.now().millisecondsSinceEpoch}',
        sender: 'bedrock',
        text: aiResponse,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
