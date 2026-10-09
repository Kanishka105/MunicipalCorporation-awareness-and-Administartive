import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/officer_task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<String> _disposalLogs = [
    'Desilting completed, waste loaded in Compactor DL-1GC-4921',
    'Excavator silt bucket transferred to Bawana Landfill',
    'Hydro-jet suction flushed 120m underground pipe',
    'Manual clearing completed & bagged for municipal hauler',
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = state.currentUser;
    final urgentTask = state.urgentTask;
    final slaSeconds = state.urgentSlaRemainingSeconds;
    final minutes = (slaSeconds / 60).floor();
    final seconds = slaSeconds % 60;
    final timeFormatted = '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s remaining';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Officer Profile Header Card
          _buildOfficerProfileHeader(context, user, isDark),
          const SizedBox(height: 16),

          // 2. Urgent Action Required Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, color: CivicColors.urgentRed, size: 20),
                  SizedBox(width: 6),
                  Text(
                    'Urgent Action\nRequired',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: CivicColors.textPrimaryLight,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Color(0xFFBE123C),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      timeFormatted,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFBE123C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. Urgent Task Card
          if (urgentTask != null) ...[
            _buildUrgentTaskCard(context, state, urgentTask, isDark),
            const SizedBox(height: 20),
          ],

          // 4. Tamper-Proof Resolution Proof Card
          _buildTamperProofSection(context, state, isDark),
          const SizedBox(height: 24),

          // 5. Completed (Audit In-Progress) Section
          _buildCompletedSection(context, state, isDark),
          const SizedBox(height: 16),

          // 6. Bottom Status Bar (Rugged outdoor mode)
          _buildRuggedModeBar(isDark),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 1. Officer Profile Header Card
  Widget _buildOfficerProfileHeader(BuildContext context, UserModel? user, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar with Online indicator
              Stack(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: CivicColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        user != null && user.role == UserRole.fieldOfficer ? 'RK' : 'RK',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: CivicColors.mint,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),

              // Officer Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          user?.role == UserRole.fieldOfficer ? user!.name : 'Rajesh\nKumar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            user?.unitId ?? 'Unit\n#3',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: CivicColors.textPrimaryLight,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Region & Accuracy Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFA7F3D0)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.wifi_tethering, color: CivicColors.mintDark, size: 13),
                              SizedBox(width: 4),
                              Text(
                                'ap-south-1',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: CivicColors.mintDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: CivicColors.mint,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'On Duty • Ward 42 Dispatch',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Accuracy ±1.8m',
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 4 Metric Boxes
          Row(
            children: [
              _buildStatBox('4', 'Assigned', isDark, false),
              const SizedBox(width: 8),
              _buildStatBox('2', 'Cleared', isDark, false),
              const SizedBox(width: 8),
              _buildStatBox('1', 'Critical', isDark, true),
              const SizedBox(width: 8),
              _buildStatBox('⭐ 4.9', 'Rating', isDark, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label, bool isDark, bool isCritical) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isCritical
              ? const Color(0xFFFEE2E2)
              : (isDark ? CivicColors.cardSurfaceDark : Colors.white),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCritical
                ? const Color(0xFFFECDD3)
                : (isDark ? CivicColors.borderDark : const Color(0xFFE2E8F0)),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: isCritical ? const Color(0xFFDC2626) : (isDark ? Colors.white : CivicColors.textPrimaryLight),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isCritical
                    ? const Color(0xFF991B1B)
                    : (isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Urgent Task Card
  Widget _buildUrgentTaskCard(
      BuildContext context, CivicAppState state, UrgentOfficerTaskModel task, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task.taskId,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PWD Sanitation',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: CivicColors.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.more_vert, size: 16, color: CivicColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 8),

                // Location Details Box
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? CivicColors.borderDark : const Color(0xFFDCFCE7),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.near_me_outlined, color: CivicColors.mintDark, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.locationName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              '${task.gpsCoordinates} • ${task.distanceAway}',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: isDark ? CivicColors.textSecondaryDark : CivicColors.mintDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Image with Simulated AI Bounding Box
          ClipRRect(
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    task.originalProofUrl,
                    fit: BoxFit.cover,
                  ),

                  // Bounding Box Rectangle Overlay
                  Positioned(
                    top: 40,
                    left: 40,
                    right: 40,
                    bottom: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEF4444), width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Top Tags
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.close, size: 12, color: Colors.white70),
                          SizedBox(width: 4),
                          Text(
                            'AWS Rekognition Confirmed',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        task.reportedTime,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  // Drain Clog Pill inside bounding box
                  Positioned(
                    top: 42,
                    right: 44,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC2626),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Drain Clog 98.4%',
                        style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  // Bottom Watermark
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Citizen Ticket: ${task.citizenTicket}',
                            style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.camera_alt, color: Colors.white70, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'Original Proof',
                                style: TextStyle(color: Colors.white70, fontSize: 10.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action Buttons: MapLibre Route & Resolve Now
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEEF2FF),
                      foregroundColor: CivicColors.primary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.navigation_outlined, size: 16),
                    label: const Text(
                      'MapLibre Route',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('MapLibre Vector Navigation: Routing to Pillar 24 (120m away)'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CivicColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.auto_fix_high, size: 16),
                    label: const Text(
                      'Resolve Now',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      _showCameraCaptureDialog(context, state);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Tamper-Proof Resolution Proof Card
  Widget _buildTamperProofSection(BuildContext context, CivicAppState state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.verified_outlined, color: CivicColors.mintDark, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tamper-Proof\nResolution Proof',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Cryptographic EXIF + Geofence Guard',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF80EED2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Step\nFunctions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46),
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Geofence Validation Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: CivicColors.mintDark),
                        const SizedBox(width: 4),
                        Text(
                          'Geofence Validation (< 15m target)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '• Within Range (${state.geofenceDistance}m)',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Precision meter line
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 6,
                    color: Colors.grey.shade300,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.72,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF007A78), Color(0xFF00D09C)],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Validated via GPS L1/L5 Dual Band + Tower Triangulation',
                  style: TextStyle(
                    fontSize: 9.5,
                    color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Post-Resolution Camera Capture Container
          Text(
            'Post-Resolution Camera Capture',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              _showCameraCaptureDialog(context, state);
            },
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? CivicColors.borderDark : const Color(0xFFCBD5E1),
                  style: BorderStyle.solid,
                ),
              ),
              child: state.capturedProofImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(state.capturedProofImage!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: CivicColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.camera_alt, color: Colors.white, size: 22),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Capture Timestamped Proof',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Watermarks GPS (28.7499, 77.1172) & Device UID',
                          style: TextStyle(
                            fontSize: 10,
                            color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 14),

          // Sanitation Disposal Audit Log dropdown
          Text(
            'Sanitation Disposal Audit Log',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: state.selectedDisposalLog,
                isExpanded: true,
                dropdownColor: isDark ? CivicColors.cardDark : Colors.white,
                items: _disposalLogs.map((log) {
                  return DropdownMenuItem(
                    value: log,
                    child: Text(
                      log,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) state.setSelectedDisposalLog(val);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Automated Verification Pipeline info
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(Icons.hub_outlined, color: CivicColors.primary, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Automated Verification Pipeline\nTriggers AWS Step Functions > Rekognition Diff > Supervisor Pass',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: CivicColors.primary,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Upload Proof & Trigger AI Audit Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: CivicColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: state.isSubmittingProof
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload_outlined, size: 18),
              label: Text(
                state.isSubmittingProof ? 'Running Rekognition AI Diff...' : 'Upload Proof & Trigger AI Audit',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              onPressed: state.isSubmittingProof
                  ? null
                  : () async {
                      final success = await state.submitResolutionProof();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: CivicColors.mintDark,
                            content: Text('✅ Audit Passed! AI Diff: 98% Cleared. Ticket marked Resolved.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  // 5. Completed (Audit In-Progress) Section
  Widget _buildCompletedSection(BuildContext context, CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.fact_check_outlined, size: 18, color: CivicColors.mintDark),
                const SizedBox(width: 6),
                Text(
                  'Completed (Audit In-\nProgress)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    height: 1.15,
                  ),
                ),
              ],
            ),
            Text(
              '${state.completedTasks.length} Verified Today',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...state.completedTasks.map((task) => _buildCompletedCard(task, isDark)),
      ],
    );
  }

  Widget _buildCompletedCard(CompletedTaskModel task, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tags
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  task.taskId,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  task.aiDiffPercent,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task.completionTime,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: CivicColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            task.title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : CivicColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 12),

          // Before & After Split Image View
          Row(
            children: [
              // Before
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(task.beforeImageUrl, fit: BoxFit.cover),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'BEFORE',
                                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.citizenLabel,
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // After
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(task.afterImageUrl, fit: BoxFit.cover),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007A78),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'AFTER',
                                  style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.officerProofLabel,
                      style: TextStyle(
                        fontSize: 10,
                        color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Triage Score Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified, size: 16, color: CivicColors.mintDark),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Triage Score: ${task.triageScore} / Pass',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        task.supervisorStatus,
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, size: 18, color: CivicColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 6. Rugged Outdoor Mode bar
  Widget _buildRuggedModeBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.vibration, size: 16, color: CivicColors.primary),
              SizedBox(width: 8),
              Text(
                'Rugged Outdoor Mode • Contrast\nOptimized',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, height: 1.15),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: CivicColors.mint,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Telemetry\nLive',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, height: 1.1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCameraCaptureDialog(BuildContext context, CivicAppState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Capture Tamper-Proof Proof'),
        content: const Text(
          'Simulate camera snapshot with GPS EXIF watermarking (28.7499° N, 77.1172° E)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: CivicColors.primary),
            onPressed: () {
              state.setCapturedProof(
                'https://images.unsplash.com/photo-1517649763962-0c623266ddc0?auto=format&fit=crop&w=600&q=80',
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📸 Timestamped proof captured with EXIF lock!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Capture & Lock', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
