import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/hazard_model.dart';
import '../models/officer_task_model.dart';
import '../models/copilot_model.dart';
import '../services/civic_storage_service.dart';

class CivicAppState extends ChangeNotifier {
  final CivicStorageService _storage = CivicStorageService();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

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

  bool _isAutoDispatched = false;
  bool get isAutoDispatched => _isAutoDispatched;

  bool _isPwdApproved = false;
  bool get isPwdApproved => _isPwdApproved;

  // Real-time SLA timer
  Timer? _slaTimer;
  int _urgentSlaRemainingSeconds = 1680; // 28m 00s
  int get urgentSlaRemainingSeconds => _urgentSlaRemainingSeconds;

  // Tamper proof form state
  double _geofenceDistance = 6.4;
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
      // Default to initial citizen
      _currentUser = const UserModel(
        id: 'usr_del_4201',
        name: 'Aarav Sharma',
        phone: '+91 98765 43210',
        email: 'aarav.sharma@dtu.ac.in',
        ward: 'DTU Ward 42',
        role: UserRole.citizen,
        karmaPoints: 340,
        streakDays: 7,
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
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
              title: 'AI Dedup',
              subtitle: 'Verified',
              isCompleted: true,
              isCurrent: false,
              iconType: 'dedup',
            ),
            ActiveSubmissionStep(
              title: 'Dispatched',
              subtitle: 'Unit #12',
              isCompleted: true,
              isCurrent: false,
              iconType: 'dispatch',
            ),
            ActiveSubmissionStep(
              title: 'Visual Diff',
              subtitle: 'Pending',
              isCompleted: false,
              isCurrent: true,
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
                'Municipal container over capacity by 200%. High pedestrian footfall blockage creating public health hazard.',
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
                'Runoff backflow risk detected before upcoming rainfall. Assigned to municipal suction trucks.',
            locationTag: 'Rohini Sec-17 Road 3 • Node #ROH-19',
            nodeCode: '#ROH-19',
            aiTag: 'Rekognition: Silt Clog (94%)',
            badgeTag: 'Sanitation Unit #4',
            isUrgent: false,
            backers: 42,
            backerSubtext: 'High locality priority',
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

    // Load completed tasks
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
            citizenLabel: 'Citizen Upload',
            officerProofLabel: 'Field Proof RK-Unit#3',
            triageScore: 0.98,
            supervisorStatus: 'Officer Sunita Verma (Zonal SE) Pending Signature',
          ),
        ];

    // Load hotspots
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

    _startSlaTimer();
    _isInitialized = true;
    notifyListeners();
  }

  void _startSlaTimer() {
    _slaTimer?.cancel();
    _slaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_urgentSlaRemainingSeconds > 0) {
        _urgentSlaRemainingSeconds--;
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
        awsRegion: 'ap-south-1',
        gpsAccuracy: 1.8,
        assignedTasks: 4,
        clearedTasks: 2,
        criticalTasks: 1,
        rating: 4.9,
        avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
      );
      _currentNavIndex = 1; // Open Tasks screen for field officer
    } else if (role == UserRole.zonalSupervisor) {
      _currentUser = UserModel(
        id: 'usr_sup_sv42',
        name: name.isNotEmpty ? name : 'Sunita Verma',
        phone: phone.isNotEmpty ? phone : '+91 98111 22334',
        email: 'sunita.verma@pwd.delhi.gov.in',
        ward: 'DTU Ward 42',
        role: UserRole.zonalSupervisor,
        unitId: 'Zonal SE #42',
        assignedTasks: 18,
        clearedTasks: 15,
        criticalTasks: 3,
        rating: 4.95,
        avatarUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=400&q=80',
      );
      _currentNavIndex = 2; // Open Copilot screen for supervisor
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
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=600&q=80',
      );
      _currentNavIndex = 0; // Feed screen
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

      // Award +10 KP
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

  // Report new civic hazard
  Future<void> submitNewHazardReport({
    required String title,
    required String description,
    required String category,
    required String locationTag,
    String? customImageUrl,
  }) async {
    final newId = 'hz_${DateTime.now().millisecondsSinceEpoch}';
    final ticketCode = 'CP-DEL-${1000 + _hazards.length + 8922}';

    final newHazard = HazardRadarModel(
      id: newId,
      ticketCode: ticketCode,
      title: title,
      description: description,
      locationTag: locationTag,
      nodeCode: '#NODE-${DateTime.now().millisecond}',
      aiTag: 'Rekognition: $category (96.8%)',
      badgeTag: '• Just Reported',
      isUrgent: false,
      backers: 1,
      backerSubtext: 'Your report',
      slaTimeLeft: '4h 00m Left',
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

  // Field Officer proof capture
  void setCapturedProof(String imagePathOrUrl) {
    _capturedProofImage = imagePathOrUrl;
    notifyListeners();
  }

  void setSelectedDisposalLog(String log) {
    _selectedDisposalLog = log;
    notifyListeners();
  }

  Future<bool> submitResolutionProof() async {
    _isSubmittingProof = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1400));

    if (_urgentTask != null) {
      _urgentTask = _urgentTask!.copyWith(isResolved: true);
      await _storage.saveUrgentTask(_urgentTask!);

      // Add to completed
      final newCompleted = CompletedTaskModel(
        taskId: _urgentTask!.taskId,
        aiDiffPercent: 'AI Diff: 98% Cleared',
        completionTime: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')} ${TimeOfDay.now().period == DayPeriod.am ? 'AM' : 'PM'}',
        title: _urgentTask!.title,
        beforeImageUrl: _urgentTask!.originalProofUrl,
        afterImageUrl: _capturedProofImage ?? 'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&w=400&q=80',
        citizenLabel: 'Citizen Upload',
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
    return true;
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

    // AI thinking
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
          '• **Recommendation**: Immediate deployment of suction compactor DL-1GC-4921 and hydro-jetting of Sector 17 ring line before upcoming 16:00 precipitation.';
    } else if (qLower.contains('brief') || qLower.contains('draft')) {
      aiResponse =
          '**Ward 42 Executive Brief (Triage Status)**:\n\n'
          '1. **Active Incidents**: 1 Critical (#TSK-881 Shahbad Drain), 3 High priority solid waste nodes.\n'
          '2. **Resource Allocation**: Compactor Unit #3 on site; Unit #12 en route to Sector 17.\n'
          '3. **AI Resolution Confidence**: 96.4% across 2 verified jobs today.\n'
          '4. **PWD Sign-off**: 1 requisition ready for Zonal SE endorsement.';
    } else {
      aiResponse =
          '**Bedrock Claude 3 Municipal Engine**:\n\n'
          'Processed telemetry for **$query** across DTU Ward 42 GIS database. '
          'SLA compliance is currently at 94.2% with 2 active field squads deployed. Preventive risk score is within baseline limits (0.34 low risk).';
    }

    _copilotMessages.removeLast(); // remove thinking
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
