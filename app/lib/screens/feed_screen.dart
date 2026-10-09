import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/hazard_model.dart';
import 'report_hazard_modal.dart';
import 'qr_scanner_modal.dart';
import 'redeem_karma_modal.dart';
import 'suggest_fix_modal.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeSub = state.activeSubmission;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Citizen Profile / Hero Card with Karma & Trust Badge
          _buildHeroProfileCard(context, state, isDark),
          const SizedBox(height: 16),

          // 2. Action Buttons Row (Report Civic Hazard & Scan QR)
          _buildActionGrid(context, state, isDark),
          const SizedBox(height: 20),

          // 3. My Active Submission Section (Real dynamic state)
          _buildActiveSubmissionSection(context, activeSub, isDark),
          const SizedBox(height: 24),

          // 4. Nearby Hazard Radar Section (Real dynamic state)
          _buildHazardRadarSection(context, state, isDark),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // 1. Citizen Karma & Trust Badge Card (Profile image removed)
  Widget _buildHeroProfileCard(BuildContext context, CivicAppState state, bool isDark) {
    final user = state.currentUser;
    final karmaPoints = user?.karmaPoints ?? 0;
    final streak = user?.streakDays ?? 1;
    final trustScore = user?.trustScore ?? 100.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : CivicColors.primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: CivicColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.verified, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$karmaPoints',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'KP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: CivicColors.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '🔥 $streak-Day Streak',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Trust: $trustScore% • Redeemable for DTC Metro passes',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),

          // Redeem Button
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const RedeemKarmaModal(),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? CivicColors.primary.withOpacity(0.2) : const Color(0xFFE0E7FE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Redeem',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: CivicColors.primary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 13,
                    color: CivicColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Action Buttons Row (Report & QR Scan)
  Widget _buildActionGrid(BuildContext context, CivicAppState state, bool isDark) {
    return Row(
      children: [
        // Left: Report Civic Hazard
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const ReportHazardModal(),
              );
            },
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: CivicColors.reportCardGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: CivicColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.tr('reportHazard'),
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'AI Auto-Triage • Auto-\nGPS & S3 Pre-signed',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: Colors.white70,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'Capture Now',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 12, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Right: Scan QR to Back Issue
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const QrScannerModal(),
              );
            },
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(14),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isDark ? CivicColors.mint.withOpacity(0.15) : CivicColors.mintBadgeBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(Icons.qr_code_scanner, color: CivicColors.mintDark, size: 20),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.tr('scanQr'),
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Physical Pole Nodes •\nNo Duplicates',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'Back Node (+10 KP)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: CivicColors.mintDark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.electric_bolt, size: 12, color: CivicColors.mintDark),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 3. My Active Submission Section (Real dynamic state with graceful empty state)
  Widget _buildActiveSubmissionSection(BuildContext context, ActiveSubmissionModel? sub, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: CivicColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'My Active Submission',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            if (sub != null)
              Text(
                sub.ticketCode,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                  letterSpacing: 0.4,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),

        if (sub == null)
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CivicColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.camera_alt_outlined, color: CivicColors.primary, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No Active Submissions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Tap "Report Civic Hazard" to file a real-time live camera report.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          Container(
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              sub.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF80EED2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF065F46),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  sub.status,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF065F46),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${sub.location} • ${sub.timeAgo}',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),

                // Stepper
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStepItem(
                        icon: Icons.check,
                        iconBg: const Color(0xFF006C4C),
                        title: 'Reported',
                        subtitle: 'Live Camera',
                        isCompleted: true,
                        isDark: isDark,
                      ),
                      _buildStepConnector(isCompleted: true),
                      _buildStepItem(
                        icon: Icons.assignment_ind_outlined,
                        iconBg: const Color(0xFF007A78),
                        title: 'Assigned',
                        subtitle: 'Unit #3',
                        subtitleColor: const Color(0xFF007A78),
                        isCompleted: true,
                        isDark: isDark,
                      ),
                      _buildStepConnector(isCompleted: true),
                      _buildStepItem(
                        icon: Icons.bolt,
                        iconBg: const Color(0xFF4F32E5),
                        title: 'In Progress',
                        subtitle: 'En Route',
                        subtitleColor: const Color(0xFF4F32E5),
                        isCompleted: true,
                        isDark: isDark,
                      ),
                      _buildStepConnector(isCompleted: false),
                      _buildStepItem(
                        icon: Icons.camera_alt_outlined,
                        iconBg: isDark ? Colors.grey.shade700 : const Color(0xFFE2E8F0),
                        iconColor: isDark ? Colors.grey.shade400 : const Color(0xFF94A3B8),
                        title: 'Resolved',
                        subtitle: 'Pending',
                        subtitleColor: isDark ? Colors.grey.shade400 : const Color(0xFF94A3B8),
                        isCompleted: false,
                        isDark: isDark,
                      ),
                      _buildStepConnector(isCompleted: false),
                      _buildStepItem(
                        icon: Icons.verified_outlined,
                        iconBg: isDark ? Colors.grey.shade700 : const Color(0xFFE2E8F0),
                        iconColor: isDark ? Colors.grey.shade400 : const Color(0xFF94A3B8),
                        title: 'Verified',
                        subtitle: 'Zonal SE',
                        subtitleColor: isDark ? Colors.grey.shade400 : const Color(0xFF94A3B8),
                        isCompleted: false,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Bottom Lock & SLA banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shield_outlined, size: 15, color: CivicColors.primary),
                          const SizedBox(width: 6),
                          Text(
                            sub.securityLockText,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showSlaDetails(context, sub, isDark);
                        },
                        child: const Text(
                          'View Live\nSLA',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: CivicColors.primary,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStepItem({
    required IconData icon,
    required Color iconBg,
    Color iconColor = Colors.white,
    required String title,
    required String subtitle,
    Color? subtitleColor,
    required bool isCompleted,
    required bool isDark,
  }) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, color: iconColor, size: 14),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
            color: subtitleColor ?? (isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight),
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector({required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: isCompleted ? CivicColors.mint : Colors.grey.shade300,
      ),
    );
  }

  // 4. Nearby Hazard Radar Section (Real dynamic data)
  Widget _buildHazardRadarSection(BuildContext context, CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CivicColors.mint, width: 1.5),
                  ),
                  child: const Icon(Icons.radar, color: CivicColors.mint, size: 16),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.tr('nearbyRadar'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      'Rohini Sector 17 • DTU Campus perimeter',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? CivicColors.primary.withOpacity(0.2) : const Color(0xFFDDE6FD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Within 650m',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: CivicColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        if (state.hazards.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle_outline, color: CivicColors.mintDark, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'All Clear in Your Radar Zone',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No open hazard complaints nearby. Tap "Report Civic Hazard" above if you spot an issue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...state.hazards.map((hazard) => _buildHazardCard(context, state, hazard, isDark)),
      ],
    );
  }

  Widget _buildHazardCard(BuildContext context, CivicAppState state, HazardRadarModel hazard, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    hazard.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: Colors.grey.shade800,
                      child: const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (hazard.badgeTag != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: hazard.isUrgent ? const Color(0xFFDC2626) : const Color(0xFF00A389),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              hazard.badgeTag!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.hub_outlined, color: CivicColors.mint, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                hazard.aiTag,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            hazard.locationTag,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            hazard.ticketCode,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hazard.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hazard.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),

                // Meta Info Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF86EFAC),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.people, size: 14, color: Color(0xFF065F46)),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${hazard.backers} Backers',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? Colors.white : const Color(0xFF065F46),
                                  ),
                                ),
                                Text(
                                  hazard.backerSubtext,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    color: isDark ? CivicColors.textMutedDark : const Color(0xFF047857),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isDark
                              ? CivicColors.cardSurfaceDark
                              : (hazard.isUrgent ? const Color(0xFFFFE4E6) : const Color(0xFFE0F2FE)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: hazard.isUrgent ? const Color(0xFFFECDD3) : const Color(0xFFBAE6FD),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                hazard.isUrgent ? Icons.hourglass_top : Icons.build_outlined,
                                size: 14,
                                color: hazard.isUrgent ? const Color(0xFFBE123C) : const Color(0xFF0369A1),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hazard.slaTimeLeft,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? Colors.white
                                        : (hazard.isUrgent ? const Color(0xFFBE123C) : const Color(0xFF0369A1)),
                                  ),
                                ),
                                Text(
                                  hazard.slaSubtext,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Action Row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hazard.hasSupported
                              ? CivicColors.mintDark
                              : (hazard.isUrgent ? CivicColors.primary : const Color(0xFFDDE6FD)),
                          foregroundColor: hazard.hasSupported || hazard.isUrgent ? Colors.white : CivicColors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: Icon(
                          hazard.hasSupported ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                          size: 16,
                        ),
                        label: Text(
                          hazard.hasSupported ? state.tr('backed') : state.tr('supportIssue'),
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          state.supportHazard(hazard.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: CivicColors.mintDark,
                              content: Text(hazard.hasSupported
                                  ? 'Removed support from ${hazard.ticketCode}'
                                  : '🎉 Supported ${hazard.ticketCode}! +10 Karma Points added.'),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Suggest a Fix button
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                      ),
                      child: TextButton.icon(
                        icon: const Icon(Icons.lightbulb_outline, size: 16, color: CivicColors.primary),
                        label: const Text('Suggest Fix', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (ctx) => SuggestFixModal(
                              ticketCode: hazard.ticketCode,
                              hazardTitle: hazard.title,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSlaDetails(BuildContext context, ActiveSubmissionModel sub, bool isDark) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? CivicColors.cardDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Live SLA Timeline: ${sub.ticketCode}',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('• 5-Step Workflow: Reported ➔ Assigned ➔ In Progress ➔ Resolved ➔ Verified'),
            SizedBox(height: 4),
            Text('• Turnaround Target: 4.0 Hours'),
            SizedBox(height: 4),
            Text('• Cryptographic EXIF Geofence: Active & Verified'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
