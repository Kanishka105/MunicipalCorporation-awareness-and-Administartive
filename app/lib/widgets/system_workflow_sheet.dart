import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

class SystemWorkflowSheet extends StatelessWidget {
  const SystemWorkflowSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hasActiveSubmission = state.activeSubmission != null;
    final isFieldAssigned = state.urgentTask != null;
    final isResolved = state.completedTasks.isNotEmpty;
    final isEscalated = state.urgentSlaRemainingSeconds < 420 && state.urgentTask != null;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CivicColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.account_tree_outlined, color: CivicColors.primary, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End-to-End System Workflow',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Live Swimlane Pipeline Tracker',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Swimlane 1: Citizen
                  _buildSwimlane(
                    title: 'Citizen',
                    color: const Color(0xFFEA580C),
                    isDark: isDark,
                    children: [
                      _buildNode(
                        'OTP login',
                        isActive: state.isAuthenticated,
                        isDark: isDark,
                        badgeText: state.isAuthenticated ? 'Authenticated ✓' : 'Required',
                        nodeColor: const Color(0xFFFFEDD5),
                        textColor: const Color(0xFF9A3412),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      _buildNode(
                        'Live photo\nreport',
                        isActive: hasActiveSubmission,
                        isDark: isDark,
                        badgeText: hasActiveSubmission ? 'EXIF Signed ✓' : 'Live Camera',
                        nodeColor: const Color(0xFFFFEDD5),
                        textColor: const Color(0xFF9A3412),
                      ),
                      const Spacer(),
                      _buildNode(
                        'Status +\nrewards',
                        isActive: isResolved,
                        isDark: isDark,
                        badgeText: isResolved ? '+25 KP Awarded ✓' : 'Pending Diff',
                        nodeColor: const Color(0xFFFFEDD5),
                        textColor: const Color(0xFF9A3412),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Swimlane 2: System + AI
                  _buildSwimlane(
                    title: 'System\n+ AI',
                    color: const Color(0xFF6366F1),
                    isDark: isDark,
                    children: [
                      const SizedBox(width: 80),
                      _buildNode(
                        'Fake check\n+ AI detect',
                        isActive: hasActiveSubmission,
                        isDark: isDark,
                        badgeText: 'pHash + Rekognition',
                        nodeColor: const Color(0xFFEEF2FF),
                        textColor: const Color(0xFF3730A3),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      _buildNode(
                        'Merge dupes\n+ SLA timer',
                        isActive: hasActiveSubmission,
                        isDark: isDark,
                        badgeText: 'Proximity Check',
                        nodeColor: const Color(0xFFEEF2FF),
                        textColor: const Color(0xFF3730A3),
                      ),
                      const Spacer(),
                      _buildNode(
                        'AI verify\nafter photo',
                        isActive: isResolved,
                        isDark: isDark,
                        badgeText: 'Diff ≥ 85% Pass',
                        nodeColor: const Color(0xFFEEF2FF),
                        textColor: const Color(0xFF3730A3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Swimlane 3: Field Worker
                  _buildSwimlane(
                    title: 'Field\nworker',
                    color: const Color(0xFFD97706),
                    isDark: isDark,
                    children: [
                      const SizedBox(width: 150),
                      _buildNode(
                        'Alert +\ntask list',
                        isActive: isFieldAssigned,
                        isDark: isDark,
                        badgeText: isFieldAssigned ? 'Unit #3 Alert' : 'Standby',
                        nodeColor: const Color(0xFFFFEDD5),
                        textColor: const Color(0xFF9A3412),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      _buildNode(
                        'Fix + take\nafter photo',
                        isActive: isFieldAssigned || isResolved,
                        isDark: isDark,
                        badgeText: 'Geofence Lock',
                        nodeColor: const Color(0xFFFFEDD5),
                        textColor: const Color(0xFF9A3412),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Swimlane 4: Officers
                  _buildSwimlane(
                    title: 'Officers',
                    color: const Color(0xFF059669),
                    isDark: isDark,
                    children: [
                      const SizedBox(width: 150),
                      _buildNode(
                        'Escalate on\nSLA miss',
                        isActive: isEscalated,
                        isDark: isDark,
                        badgeText: isEscalated ? '75% Threshold Alert' : 'Normal Monitored',
                        nodeColor: const Color(0xFFD1FAE5),
                        textColor: const Color(0xFF065F46),
                      ),
                      const Spacer(),
                      _buildNode(
                        'Heatmap +\nAI summary',
                        isActive: true,
                        isDark: isDark,
                        badgeText: 'Bedrock Claude 3',
                        nodeColor: const Color(0xFFD1FAE5),
                        textColor: const Color(0xFF065F46),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Live Workflow Checklist
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? CivicColors.borderDark : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active Pipeline Telemetry Verification',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildChecklistRow('1. Citizen Mobile OTP Login (MFA active)', state.isAuthenticated),
                        _buildChecklistRow('2. Live photo report (Gallery upload blocked)', hasActiveSubmission),
                        _buildChecklistRow('3. EXIF GPS lock + pHash fake photo check', hasActiveSubmission),
                        _buildChecklistRow('4. Proximity duplicate merge + SLA timer started', hasActiveSubmission),
                        _buildChecklistRow('5. Alert dispatched to Field Worker Task List', isFieldAssigned || isResolved),
                        _buildChecklistRow('6. Geofenced after-photo captured at site', isResolved),
                        _buildChecklistRow('7. Rekognition AI verify (diff check score)', isResolved),
                        _buildChecklistRow('8. Citizen Karma points credited (+25 KP)', isResolved),
                        _buildChecklistRow('9. Bedrock GIS Heatmap & Executive Brief updated', true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwimlane({
    required String title,
    required Color color,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: color,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Row(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNode(
    String label, {
    required bool isActive,
    required bool isDark,
    required String badgeText,
    required Color nodeColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? nodeColor : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? textColor.withOpacity(0.5) : Colors.grey.shade400,
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isActive ? textColor : Colors.grey,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            badgeText,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              color: isActive ? textColor.withOpacity(0.8) : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistRow(String title, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 15,
            color: isDone ? CivicColors.mintDark : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
                color: isDone ? CivicColors.mintDark : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
