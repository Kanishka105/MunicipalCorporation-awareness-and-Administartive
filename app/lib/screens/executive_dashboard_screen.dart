import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/executive_dashboard_model.dart';

class ExecutiveDashboardScreen extends StatelessWidget {
  const ExecutiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentRole = state.dashboardRole;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Role View Switcher
          _buildRoleSwitcher(context, state, isDark),
          const SizedBox(height: 14),

          // 2. Bedrock AI-Written Executive Summary
          _buildBedrockExecutiveSummary(state, isDark),
          const SizedBox(height: 16),

          // 3. Top KPI Cards
          _buildKpiCardsRow(state, isDark),
          const SizedBox(height: 16),

          // 4. Low-Confidence AI Manual Review Queue (< 80% AI Confidence)
          _buildReviewQueueSection(context, state, isDark),
          const SizedBox(height: 20),

          // 5. Ward SLA & Escalation Comparison Matrix
          _buildWardComparisonSection(state, isDark),
          const SizedBox(height: 20),

          // 6. Cold Zones (No Reports in 14d - Preventive Patrol)
          _buildColdZonesSection(context, state, isDark),
          const SizedBox(height: 20),

          // 7. Security & Compliance Footer
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
          final isSelected = state.dashboardRole == r['role'] &&
              (r['label'] == 'Zonal Officer'
                  ? state.currentUser?.role == UserRole.zonalInspector
                  : state.dashboardRole == r['role']);

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

  // 2. Bedrock AI-Written Executive Summary
  Widget _buildBedrockExecutiveSummary(CivicAppState state, bool isDark) {
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
                child: const Text('Hourly Sync', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '“12 SLA misses in Ward 7 (Civil Lines) this week due to compactor chassis repair. Ward 42 Rohini maintained 96.4% on-time resolution. Action: Divert backup Compactor DL-1GC-4921 to Ward 7 at 14:00.”',
            style: TextStyle(color: Colors.white, fontSize: 12.5, height: 1.35, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // 3. Top KPI Cards
  Widget _buildKpiCardsRow(CivicAppState state, bool isDark) {
    return Row(
      children: [
        _buildKpiCard('24', 'Open Tickets', CivicColors.primary, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('0', 'Ward 42 SLA Miss', CivicColors.mintDark, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('12', 'Regional Misses', CivicColors.urgentRed, isDark),
        const SizedBox(width: 8),
        _buildKpiCard('98.4%', 'Trust Score', const Color(0xFFD97706), isDark),
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
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${state.reviewQueue.where((r) => r.status == 'pending').length} Pending Review',
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF991B1B)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

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
                  child: Image.network(item.imageUrl, fit: BoxFit.cover),
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

          // Action buttons: Approve / Reject
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
          'Ward SLA & Escalation Comparison',
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
                          '${ward.clearanceRatePct}% Resolved',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: CivicColors.primary),
                        ),
                        Text(
                          '${ward.slaMisses} SLA Misses',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: ward.slaMisses > 0 ? const Color(0xFFDC2626) : Colors.grey,
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

  // 6. Cold Zones (No Reports in 14d)
  Widget _buildColdZonesSection(BuildContext context, CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.ac_unit, color: Colors.blueAccent, size: 16),
            SizedBox(width: 6),
            Text(
              'Cold Zones (Zero Reports in 14d - Preventive Patrol)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 10),

        ...state.coldZones.map((cz) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardDark : const Color(0xFFF0F9FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: isDark ? CivicColors.borderDark : const Color(0xFFBAE6FD)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cz.name} (${cz.daysWithoutReport})',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Risk: ${cz.riskFactor} • Action: ${cz.suggestedAction}',
                        style: TextStyle(
                          fontSize: 10.5,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Patrol squad routed to ${cz.name}!')),
                    );
                  },
                  child: const Text('Dispatch Patrol', style: TextStyle(fontSize: 10.5)),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // 7. Security & Compliance Footer
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
