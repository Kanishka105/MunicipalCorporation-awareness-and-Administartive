import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/executive_dashboard_model.dart';
import '../widgets/system_workflow_sheet.dart';

class ExecutiveDashboardScreen extends StatelessWidget {
  const ExecutiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Role View Switcher
          _buildRoleSwitcher(context, state, isDark),
          const SizedBox(height: 12),

          // 2. Workflow Pipeline Architecture Button
          _buildWorkflowHeaderCard(context, isDark),
          const SizedBox(height: 14),

          // 3. Bedrock AI-Written Executive Summary
          _buildBedrockExecutiveSummary(state, isDark),
          const SizedBox(height: 16),

          // 3. Top KPI Cards
          _buildKpiCardsRow(state, isDark),
          const SizedBox(height: 16),

          // 4. Low-Confidence AI Manual Review Queue
          _buildReviewQueueSection(context, state, isDark),
          const SizedBox(height: 20),

          // 5. Ward SLA & Escalation Comparison Matrix
          _buildWardComparisonSection(state, isDark),
          const SizedBox(height: 20),

          // 6. Security & Compliance Footer
          _buildSecurityFooter(isDark),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // 1. Role View Switcher (Inspector, Zonal Officer, Commissioner, State)
  Widget _buildRoleSwitcher(BuildContext context, CivicAppState state, bool isDark) {
    final roles = [
      {'role': UserRole.zonalInspector, 'label': 'Inspector'},
      {'role': UserRole.zonalInspector, 'label': 'Zonal Officer'},
      {'role': UserRole.commissioner, 'label': 'Commissioner'},
      {'role': UserRole.stateAdmin, 'label': 'State Apex'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: roles.map((r) {
          final isSelected = state.dashboardRole == r['role'];

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                r['label'] as String,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : CivicColors.textPrimaryLight),
                ),
              ),
              selected: isSelected,
              selectedColor: CivicColors.primary,
              backgroundColor: isDark ? CivicColors.cardDark : CivicColors.bgLight,
              onSelected: (_) {
                state.setDashboardRole(r['role'] as UserRole);
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // 2. Workflow Pipeline Architecture Button
  Widget _buildWorkflowHeaderCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFC7D2FE),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.schema_outlined, color: CivicColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'End-to-End System Architecture Pipeline',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
                Text(
                  'Citizen ➔ AI Detect ➔ Field Worker ➔ Officers Lifecycle',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: CivicColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const SystemWorkflowSheet(),
              );
            },
            child: const Text('Open Flow', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // 3. Bedrock AI-Written Executive Summary
  Widget _buildBedrockExecutiveSummary(CivicAppState state, bool isDark) {
    final openCount = state.hazards.length;
    final clearedCount = state.completedTasks.length;
    final trustScore = state.currentUser?.trustScore ?? 100.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF4338CA),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4338CA).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.auto_awesome, color: CivicColors.mintLight, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Bedrock AI Executive Briefing (ap-south-1)',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Live Sync', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '“Ward 42 Telemetry: $openCount active complaints registered in system. $clearedCount tasks cleared with verified cryptographic EXIF proof. Average citizen trust index is $trustScore%.”',
            style: const TextStyle(color: Colors.white, fontSize: 12.5, height: 1.35, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // 3. Top KPI Cards (Real dynamic counts)
  Widget _buildKpiCardsRow(CivicAppState state, bool isDark) {
    return Row(
      children: [
        _buildKpiCard('${state.hazards.length}', 'Open Tickets', CivicColors.primary, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('${state.completedTasks.length}', 'Cleared Today', CivicColors.mintDark, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('${state.urgentTask != null ? 1 : 0}', 'Urgent Action', CivicColors.urgentRed, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('${state.currentUser?.trustScore ?? 100.0}%', 'Trust Score', const Color(0xFFD97706), isDark),
      ],
    );
  }

  Widget _buildKpiCard(String val, String label, Color col, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: isDark ? CivicColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
        ),
        child: Column(
          children: [
            Text(
              val,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: col),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Low-Confidence AI Manual Review Queue
  Widget _buildReviewQueueSection(BuildContext context, CivicAppState state, bool isDark) {
    final pendingCount = state.reviewQueue.where((r) => r.status == 'pending').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.rate_review_outlined, color: CivicColors.primary, size: 18),
                const SizedBox(width: 6),
                Text(
                  'Low-Confidence AI Review Queue',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: pendingCount > 0 ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$pendingCount Pending Review',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: pendingCount > 0 ? const Color(0xFF991B1B) : const Color(0xFF065F46),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        if (state.reviewQueue.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
            ),
            child: Center(
              child: Text(
                'All incoming citizen reports verified by Rekognition. Review queue empty.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                ),
              ),
            ),
          )
        else
          ...state.reviewQueue.map((item) => _buildReviewItemCard(context, state, item, isDark)),
      ],
    );
  }

  Widget _buildReviewItemCard(
      BuildContext context, CivicAppState state, LowConfidenceReviewItem item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.status == 'approved'
              ? CivicColors.mint
              : (item.status == 'rejected'
                  ? CivicColors.urgentRed
                  : (isDark ? CivicColors.borderDark : CivicColors.borderLight)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      color: Colors.grey.shade800,
                      child: const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.ticketCode,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'AI Conf: ${item.aiConfidence}%',
                            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFFDC2626)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Flag: ${item.flagReason}',
                      style: const TextStyle(fontSize: 10, color: Color(0xFFD97706)),
                    ),
                    Text(
                      'Reporter: ${item.citizenMaskedPhone} (Masked DPDP)',
                      style: TextStyle(
                        fontSize: 9.5,
                        color: isDark ? CivicColors.textMutedDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          if (item.status == 'pending')
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CivicColors.urgentRed,
                      side: const BorderSide(color: CivicColors.urgentRed),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    icon: const Icon(Icons.close, size: 14),
                    label: const Text('Reject Fake', style: TextStyle(fontSize: 11)),
                    onPressed: () {
                      state.reviewItemAction(item.id, false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Rejected ${item.ticketCode} - pHash flagged as duplicate/fake.')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CivicColors.mintDark,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    icon: const Icon(Icons.check, size: 14),
                    label: const Text('Verify & Dispatch', style: TextStyle(fontSize: 11)),
                    onPressed: () {
                      state.reviewItemAction(item.id, true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verified ${item.ticketCode}! Assigned to field squad.')),
                      );
                    },
                  ),
                ),
              ],
            )
          else
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: item.status == 'approved' ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  item.status == 'approved' ? '✓ Approved by Official' : '✕ Rejected (Flagged Fake/Duplicate)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: item.status == 'approved' ? const Color(0xFF065F46) : const Color(0xFF991B1B),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 5. Ward SLA & Escalation Comparison Matrix
  Widget _buildWardComparisonSection(CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ward SLA & Telemetry Summary',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: isDark ? CivicColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
          ),
          child: Column(
            children: state.wardComparisons.map((ward) {
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
                      width: 0.8,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ward.wardName,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                            ),
                          ),
                          Text(
                            ward.escalationLevel,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: ward.slaMisses > 0 ? const Color(0xFFDC2626) : CivicColors.mintDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${ward.clearanceRatePct.toStringAsFixed(1)}% Resolved',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: CivicColors.primary),
                        ),
                        Text(
                          '${ward.openComplaints} Open Complaints',
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // 6. Security & Compliance Footer
  Widget _buildSecurityFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.shield_outlined, size: 14, color: CivicColors.mintDark),
              SizedBox(width: 6),
              Text(
                'AWS Cognito RBAC • ap-south-1 (Mumbai Region)',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CivicColors.mintDark),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Live-Camera EXIF Signed • DPDP Act Compliant (Masked Phones) • CloudTrail Audit AES-256',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.5, color: CivicColors.textSecondaryLight),
          ),
        ],
      ),
    );
  }
}
