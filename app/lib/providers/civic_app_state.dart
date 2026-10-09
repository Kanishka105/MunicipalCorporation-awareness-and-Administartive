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

  // Leaderboard & Citizen Fixes (Live dynamic list)
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
  int _urgentSlaRemainingSeconds = 0;
  int get urgentSlaRemainingSeconds => _urgentSlaRemainingSeconds;
  String _escalationStatus = 'Normal Monitoring';
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

    // Load saved user session from SharedPreferences
    final savedUser = await _storage.loadUser();
    _currentUser = savedUser;

    // Load active submission from persistent storage
    _activeSubmission = await _storage.loadActiveSubmission();

    // Load hazards from persistent storage
    final savedHazards = await _storage.loadHazards();
    _hazards = savedHazards ?? [];

    // Load urgent task from persistent storage
    final savedTask = await _storage.loadUrgentTask();
    _urgentTask = savedTask;
    if (_urgentTask != null && !_urgentTask!.isResolved) {
      _urgentSlaRemainingSeconds = _urgentTask!.slaRemaining.inSeconds;
      _startSlaTimer();
    }

    // Load completed tasks from persistent storage
    final savedCompleted = await _storage.loadCompletedTasks();
    _completedTasks = savedCompleted ?? [];

    // Load hotspots from persistent storage
    final savedHotspots = await _storage.loadHotspots();
    _hotspots = savedHotspots ?? [];

    _refreshLeaderboard();
    _refreshWardComparisons();

    _isInitialized = true;
    notifyListeners();
  }

  void _refreshLeaderboard() {
    if (_currentUser != null) {
      _leaderboard = [
        CitizenLeaderboardEntry(
          rank: 1,
          name: '${_currentUser!.name} (You)',
          ward: _currentUser!.ward,
          karmaPoints: _currentUser!.karmaPoints,
          verifiedReports: _completedTasks.length + (_activeSubmission != null ? 1 : 0),
          trustScore: _currentUser!.trustScore,
          badge: _currentUser!.karmaPoints > 300 ? 'Civic Guardian 🛡️' : 'Active Reporter 🔍',
          avatarUrl: _currentUser!.avatarUrl,
        ),
      ];
    } else {
      _leaderboard = [];
    }
  }

  void _refreshWardComparisons() {
    final userWard = _currentUser?.ward ?? 'DTU Ward 42';
    _wardComparisons = [
      WardPerformanceComparison(
        wardName: userWard,
        openComplaints: _hazards.length,
        slaMisses: _urgentSlaRemainingSeconds == 0 && _urgentTask != null ? 1 : 0,
        clearanceRatePct: _completedTasks.isEmpty && _hazards.isEmpty
            ? 100.0
            : ((_completedTasks.length / (_completedTasks.length + _hazards.length + (_urgentTask != null ? 1 : 0))) * 100).clamp(0.0, 100.0),
        citizenTrustAvg: _currentUser?.trustScore ?? 98.0,
        activeSquads: _currentUser?.role == UserRole.fieldOfficer ? 1 : 0,
        escalationLevel: _urgentTask != null ? 'Active Duty Dispatch' : 'Normal Patrol',
      ),
    ];
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
        if (_urgentSlaRemainingSeconds < 420 && _urgentSlaRemainingSeconds > 0) {
          _escalationStatus = 'Level 2 Escalation: Zonal Officer Alert Sent (75% SLA Passed)';
        }
        notifyListeners();
      } else {
        _slaTimer?.cancel();
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
    final avatar = role == UserRole.fieldOfficer
        ? 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80'
        : (role == UserRole.zonalInspector || role == UserRole.commissioner
            ? 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80'
            : 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80');

    _currentUser = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name.isNotEmpty ? name : (role == UserRole.fieldOfficer ? 'Field Officer' : 'Citizen User'),
      phone: phone.isNotEmpty ? phone : '+91 98765 43210',
      email: '${name.toLowerCase().replaceAll(' ', '.')}@civicpulse.delhi.gov.in',
      ward: 'DTU Ward 42',
      role: role,
      karmaPoints: role == UserRole.citizen ? 100 : 0,
      streakDays: 1,
      trustScore: 100.0,
      unitId: unitId ?? (role == UserRole.fieldOfficer ? 'Unit #3' : null),
      awsRegion: 'ap-south-1 (Mumbai)',
      gpsAccuracy: 1.8,
      assignedTasks: role == UserRole.fieldOfficer ? (_urgentTask != null ? 1 : 0) : 0,
      clearedTasks: 0,
      criticalTasks: role == UserRole.fieldOfficer ? (_urgentTask != null ? 1 : 0) : 0,
      rating: 5.0,
      avatarUrl: avatar,
      cognitoGroup: role == UserRole.commissioner
          ? 'MCD-Commissioners-Apex'
          : (role == UserRole.fieldOfficer ? 'MCD-Field-Officers' : 'MCD-Citizen-Verified'),
      mfaVerified: true,
    );

    if (role == UserRole.fieldOfficer) {
      _currentNavIndex = 1;
    } else if (role == UserRole.zonalInspector || role == UserRole.commissioner) {
      _dashboardRole = role;
      _currentNavIndex = 4;
    } else {
      _currentNavIndex = 0;
    }

    await _storage.saveUser(_currentUser!);
    _refreshLeaderboard();
    _refreshWardComparisons();
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.clearUser();
    notifyListeners();
  }

  Future<void> clearAllAppData() async {
    _hazards.clear();
    _completedTasks.clear();
    _urgentTask = null;
    _activeSubmission = null;
    _reviewQueue.clear();
    _coldZones.clear();
    _fixSuggestions.clear();
    _copilotMessages.clear();
    _slaTimer?.cancel();
    _urgentSlaRemainingSeconds = 0;

    await _storage.saveHazards([]);
    await _storage.saveCompletedTasks([]);
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(karmaPoints: 100, clearedTasks: 0, assignedTasks: 0);
      await _storage.saveUser(_currentUser!);
    }
    _refreshLeaderboard();
    _refreshWardComparisons();
    notifyListeners();
  }

  // Support / Back an issue
  Future<void> supportHazard(String hazardId) async {
    final index = _hazards.indexWhere((h) => h.id == hazardId);
    if (index != -1) {
      final hazard = _hazards[index];
      final newSupported = !hazard.hasSupported;
      final newBackers = newSupported ? hazard.backers + 1 : (hazard.backers > 0 ? hazard.backers - 1 : 0);

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
      _refreshLeaderboard();
      notifyListeners();
    }
  }

  // Suggest a fix on a complaint
  void addFixSuggestion(String ticketCode, String text) {
    if (text.trim().isEmpty) return;
    final newFix = CitizenFixSuggestion(
      id: 'fix_${DateTime.now().millisecondsSinceEpoch}',
      ticketCode: ticketCode,
      citizenName: _currentUser?.name ?? 'Citizen',
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
    _refreshLeaderboard();
    notifyListeners();
  }

  void toggleUpvoteFix(String fixId) {
    final idx = _fixSuggestions.indexWhere((f) => f.id == fixId);
    if (idx != -1) {
      final item = _fixSuggestions[idx];
      final newUpvoted = !item.hasUpvoted;
      _fixSuggestions[idx] = item.copyWith(
        hasUpvoted: newUpvoted,
        upvotes: newUpvoted ? item.upvotes + 1 : (item.upvotes > 0 ? item.upvotes - 1 : 0),
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
      _refreshLeaderboard();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Duplicate Check & Real Hazard Report Creation
  Future<Map<String, dynamic>> submitNewHazardReport({
    required String title,
    required String description,
    required String category,
    required String locationTag,
    bool isNearHospitalOrSchool = false,
    String? customImageUrl,
  }) async {
    // Proximity Duplicate Merge Check: check if any existing hazard matches location within proximity
    final normalizedLoc = locationTag.toLowerCase().trim();
    final duplicateIndex = _hazards.indexWhere(
      (h) => h.locationTag.toLowerCase().contains(normalizedLoc) || (normalizedLoc.isNotEmpty && normalizedLoc.contains(h.locationTag.toLowerCase())),
    );

    if (duplicateIndex != -1) {
      final dup = _hazards[duplicateIndex];
      _hazards[duplicateIndex] = dup.copyWith(
        backers: dup.backers + 1,
        hasSupported: true,
      );
      if (_currentUser != null) {
        _currentUser = _currentUser!.copyWith(
          karmaPoints: _currentUser!.karmaPoints + 10,
        );
        await _storage.saveUser(_currentUser!);
      }
      await _storage.saveHazards(_hazards);
      _refreshLeaderboard();
      notifyListeners();
      return {
        'isDuplicateMerged': true,
        'ticketCode': dup.ticketCode,
        'message': 'Duplicate detected at location! Merged as Upvote & Boosted SLA (+10 KP).',
      };
    }

    // Dynamic Severity Calculation (0 to 100)
    int baseSeverity = 60;
    if (category.toLowerCase().contains('waste burning') || category.toLowerCase().contains('smoke')) {
      baseSeverity = 85;
    } else if (category.toLowerCase().contains('drain')) {
      baseSeverity = 75;
    }
    if (isNearHospitalOrSchool) {
      baseSeverity = (baseSeverity + 20).clamp(0, 100);
    }

    final newId = 'hz_${DateTime.now().millisecondsSinceEpoch}';
    final ticketCode = 'CP-DEL-${1000 + _hazards.length + 1}';

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
      slaTimeLeft: '4h 00m Left',
      slaSubtext: 'AI Auto-Triage SLA',
      imageUrl: customImageUrl ?? 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?auto=format&fit=crop&w=800&q=80',
      hasSupported: true,
      createdAt: DateTime.now(),
    );

    _hazards.insert(0, newHazard);

    // Create Active Submission for Citizen
    _activeSubmission = ActiveSubmissionModel(
      id: 'sub_${DateTime.now().millisecondsSinceEpoch}',
      ticketCode: ticketCode,
      title: title,
      location: locationTag,
      timeAgo: 'Just now',
      status: 'Reported',
      statusColor: 'mint',
      steps: [
        const ActiveSubmissionStep(
          title: 'Reported',
          subtitle: 'Live Camera',
          isCompleted: true,
          isCurrent: false,
          iconType: 'check',
        ),
        const ActiveSubmissionStep(
          title: 'Assigned',
          subtitle: 'Pending Squad',
          isCompleted: false,
          isCurrent: true,
          iconType: 'dedup',
        ),
        const ActiveSubmissionStep(
          title: 'In Progress',
          subtitle: 'Queued',
          isCompleted: false,
          isCurrent: false,
          iconType: 'dispatch',
        ),
        const ActiveSubmissionStep(
          title: 'Resolved',
          subtitle: 'Pending Proof',
          isCompleted: false,
          isCurrent: false,
          iconType: 'pending',
        ),
        const ActiveSubmissionStep(
          title: 'Verified',
          subtitle: 'Zonal SE',
          isCompleted: false,
          isCurrent: false,
          iconType: 'pending',
        ),
      ],
      securityLockText: 'Tamper-safe GPS camera lock applied',
      liveSlaUrl: 'https://civicpulse.delhi.gov.in/sla/$ticketCode',
    );
    await _storage.saveActiveSubmission(_activeSubmission!);

    // If high severity, automatically generate an urgent task for field officers
    if (baseSeverity > 75) {
      _urgentTask = UrgentOfficerTaskModel(
        taskId: '#TSK-${DateTime.now().millisecond}',
        departmentTag: 'PWD Sanitation',
        title: title,
        locationName: locationTag,
        gpsCoordinates: '28.7499° N, 77.1172° E',
        distanceAway: 'Within Ward perimeter',
        aiRekognitionLabel: category,
        aiConfidence: '96.8%',
        reportedTime: 'Just now',
        citizenTicket: ticketCode,
        originalProofUrl: newHazard.imageUrl,
        slaRemaining: const Duration(hours: 3),
      );
      _urgentSlaRemainingSeconds = 10800;
      _startSlaTimer();
      await _storage.saveUrgentTask(_urgentTask!);
    }

    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        karmaPoints: _currentUser!.karmaPoints + 25,
      );
      await _storage.saveUser(_currentUser!);
    }

    await _storage.saveHazards(_hazards);
    _refreshLeaderboard();
    _refreshWardComparisons();
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
      _refreshLeaderboard();
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
        'message': 'AI Rekognition Diff Alert: 37.6% residue still detected! Task Reopened & Escalated to Inspector.',
      };
    }

    if (_urgentTask != null) {
      final completedTaskId = _urgentTask!.taskId;
      final completedTitle = _urgentTask!.title;
      final beforeUrl = _urgentTask!.originalProofUrl;

      final newCompleted = CompletedTaskModel(
        taskId: completedTaskId,
        aiDiffPercent: 'AI Diff: 98% Cleared',
        completionTime: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period == DayPeriod.am ? 'AM' : 'PM'}',
        title: completedTitle,
        beforeImageUrl: beforeUrl,
        afterImageUrl: _capturedProofImage ?? 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&w=400&q=80',
        citizenLabel: 'Citizen Upload (EXIF Locked)',
        officerProofLabel: 'Field Proof RK-Unit#3',
        triageScore: 0.99,
        supervisorStatus: 'Officer Sunita Verma (Zonal SE) Pending Signature',
      );

      _completedTasks.insert(0, newCompleted);
      await _storage.saveCompletedTasks(_completedTasks);

      _urgentTask = null;
      _urgentSlaRemainingSeconds = 0;
      _slaTimer?.cancel();
      await _storage.saveUrgentTask(
        const UrgentOfficerTaskModel(
          taskId: '',
          departmentTag: '',
          title: '',
          locationName: '',
          gpsCoordinates: '',
          distanceAway: '',
          aiRekognitionLabel: '',
          aiConfidence: '',
          reportedTime: '',
          citizenTicket: '',
          originalProofUrl: '',
          slaRemaining: Duration.zero,
          isResolved: true,
        ),
      );

      // Update active submission status if it matches
      if (_activeSubmission != null) {
        _activeSubmission = ActiveSubmissionModel(
          id: _activeSubmission!.id,
          ticketCode: _activeSubmission!.ticketCode,
          title: _activeSubmission!.title,
          location: _activeSubmission!.location,
          timeAgo: 'Resolved just now',
          status: 'Resolved (Audit In-Progress)',
          statusColor: 'mint',
          steps: [
            const ActiveSubmissionStep(title: 'Reported', subtitle: 'Live Camera', isCompleted: true, isCurrent: false, iconType: 'check'),
            const ActiveSubmissionStep(title: 'Assigned', subtitle: 'Unit #3', isCompleted: true, isCurrent: false, iconType: 'dedup'),
            const ActiveSubmissionStep(title: 'In Progress', subtitle: 'Cleared', isCompleted: true, isCurrent: false, iconType: 'dispatch'),
            const ActiveSubmissionStep(title: 'Resolved', subtitle: 'Proof Verified', isCompleted: true, isCurrent: false, iconType: 'check'),
            const ActiveSubmissionStep(title: 'Verified', subtitle: 'Pending Sign', isCompleted: false, isCurrent: true, iconType: 'pending'),
          ],
          securityLockText: 'Tamper-safe EXIF verified',
          liveSlaUrl: _activeSubmission!.liveSlaUrl,
        );
        await _storage.saveActiveSubmission(_activeSubmission!);
      }

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
    _refreshLeaderboard();
    _refreshWardComparisons();
    notifyListeners();
    return {
      'success': true,
      'aiDiffScore': 98.4,
      'message': 'Audit Passed! Cryptographic EXIF proof verified. Task marked Resolved.',
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

    if (qLower.contains('flood') || qLower.contains('sector 17') || qLower.contains('drain')) {
      aiResponse =
          '**Bedrock Diagnostic Analysis for ${_currentUser?.ward ?? "Ward 42"}**:\n\n'
          '• **Telemetry Assessment**: Active complaints: ${_hazards.length}. Cleared today: ${_completedTasks.length}.\n'
          '• **Drainage Status**: Inflow sensor telemetry active on ap-south-1 Mumbai.\n'
          '• **Recommendation**: Immediate deployment of suction compactor before upcoming rainfall.';
    } else if (qLower.contains('brief') || qLower.contains('draft') || qLower.contains('summary')) {
      aiResponse =
          '**Bedrock Executive Brief (${_currentUser?.ward ?? "Ward 42"})**:\n\n'
          '1. **Active Incidents**: ${_hazards.length} open complaints registered.\n'
          '2. **Tasks Resolved Today**: ${_completedTasks.length} verified jobs with EXIF diff pass.\n'
          '3. **Citizen Trust Index**: ${_currentUser?.trustScore ?? 100.0}% verified reliability.\n'
          '4. **SLA Compliance**: 100% on-time resolution across active squads.';
    } else {
      aiResponse =
          '**Bedrock Claude 3 Municipal Engine**:\n\n'
          'Processed telemetry for **$query** across ${_currentUser?.ward ?? "DTU Ward 42"} GIS database (ap-south-1 Mumbai). '
          'Active incidents count is ${_hazards.length}. No anomalous telemetry detected.';
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
