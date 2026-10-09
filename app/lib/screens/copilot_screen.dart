import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/copilot_model.dart';

class CopilotScreen extends StatefulWidget {
  const CopilotScreen({super.key});

  @override
  State<CopilotScreen> createState() => _CopilotScreenState();
}

class _CopilotScreenState extends State<CopilotScreen> {
  final TextEditingController _queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendQuery(CivicAppState state, String text) {
    if (text.trim().isEmpty) return;
    state.sendCopilotQuery(text.trim());
    _queryController.clear();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Copilot Mode Banner
                _buildCopilotBanner(isDark),
                const SizedBox(height: 12),

                // 2. Quick Prompt Chips
                _buildQuickPromptChips(state, isDark),
                const SizedBox(height: 14),

                // 3. Prompt Context Card (Deep Blue)
                _buildPromptContextCard(),
                const SizedBox(height: 16),

                // 4. Bedrock Diagnostic Engine Card
                _buildBedrockDiagnosticCard(context, state, isDark),
                const SizedBox(height: 20),

                // 5. Ward 42 Preventive Hotspot Ledger
                _buildHotspotLedgerSection(context, state, isDark),
                const SizedBox(height: 16),

                // Dynamic Live Chat Messages (if any)
                if (state.copilotMessages.isNotEmpty) ...[
                  _buildChatHistory(state, isDark),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ),

        // 6. Floating Copilot Input Bar
        _buildBottomInputBar(state, isDark),
      ],
    );
  }

  // 1. Top Copilot Mode Banner
  Widget _buildCopilotBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CivicColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Officer Copilot',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF80EED2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Bedrock Claude 3',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ),
                    const Spacer(),
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
                        const SizedBox(width: 4),
                        const Text(
                          'LIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: CivicColors.mintDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Ward 42 Regional Sector 17-42 • Active GIS Stream',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Quick Prompt Chips
  Widget _buildQuickPromptChips(CivicAppState state, bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildPromptChip(
            icon: Icons.water_damage_outlined,
            label: 'Why does Sector 17 flood?',
            isDark: isDark,
            onTap: () => _sendQuery(state, 'Why does Sector 17 flood?'),
          ),
          const SizedBox(width: 8),
          _buildPromptChip(
            icon: Icons.description_outlined,
            label: 'Draft Ward 42 Brief',
            isDark: isDark,
            onTap: () => _sendQuery(state, 'Draft Ward 42 Brief'),
          ),
          const SizedBox(width: 8),
          _buildPromptChip(
            icon: Icons.shield_outlined,
            label: 'Run Triage Risk Matrix',
            isDark: isDark,
            onTap: () => _sendQuery(state, 'Run Triage Risk Matrix for DTU Sector'),
          ),
        ],
      ),
    );
  }

  Widget _buildPromptChip({
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? CivicColors.cardDark : const Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: CivicColors.primary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Prompt Context Card (Deep Blue)
  Widget _buildPromptContextCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4338CA),
        borderRadius: BorderRadius.circular(20),
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
            children: const [
              Icon(Icons.badge_outlined, color: Colors.white70, size: 15),
              SizedBox(width: 6),
              Text(
                'Assistant Field Officer • DTU Sector',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Analyze recurring waste accumulation at DTU North Gate (Ticket #CP-DEL-8921) and propose preventive maintenance.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Prompt Latency: 420ms',
                style: TextStyle(color: Colors.white60, fontSize: 10.5),
              ),
              Text(
                '11:42 AM',
                style: TextStyle(color: Colors.white60, fontSize: 10.5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 4. Bedrock Diagnostic Engine Card
  Widget _buildBedrockDiagnosticCard(BuildContext context, CivicAppState state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_awesome, color: CivicColors.primary, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bedrock Diagnostic\nEngine',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Trained on Municipal Bylaws & 3-Year Historical GIS Log',
                      style: TextStyle(
                        fontSize: 10,
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
                  '99.4%\nConf.',
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
          const SizedBox(height: 16),

          // Section 1: Root Cause Synthesis
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? CivicColors.borderDark : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.article_outlined, color: CivicColors.primary, size: 15),
                    SizedBox(width: 6),
                    Text(
                      'Root Cause Synthesis',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: CivicColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                      height: 1.35,
                    ),
                    children: const [
                      TextSpan(text: 'Historical correlation of '),
                      TextSpan(
                        text: '14 incidents',
                        style: TextStyle(fontWeight: FontWeight.w800, color: CivicColors.primary),
                      ),
                      TextSpan(
                          text:
                              ' over 6 weeks during student shift changeovers (12:30 PM – 2:00 PM). Existing 1.2m³ container capacity exceeds peak inflow threshold by '),
                      TextSpan(
                        text: '180%',
                        style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFFDC2626)),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Load Threshold Bar
                Text(
                  'Peak Inflow Load Threshold 2.8m³ / 1.2m³ Capacity',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 6,
                    color: Colors.grey.shade300,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Section 2: Immediate Triage Action (Pre-SLA breach)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF80EED2).withOpacity(0.35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF80EED2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.bolt, color: Color(0xFF065F46), size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Immediate Triage Action (Pre-\nSLA breach)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF065F46),
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ETA\n18m',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF065F46),
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Dispatch Compactor DL-1GC-4921 to DTU North Gate perimeter before the 13:00 rush.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 10),

                // Driver & Auto-Dispatch Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Driver: Rajesh K. (Nearby Sector\n16)',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF047857),
                        height: 1.15,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isAutoDispatched ? const Color(0xFF065F46) : Colors.white,
                        foregroundColor: state.isAutoDispatched ? Colors.white : const Color(0xFF065F46),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        state.triggerAutoDispatch();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: CivicColors.mintDark,
                            content: Text('⚡ Auto-Dispatched Compactor DL-1GC-4921! Driver acknowledged.'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Text(
                        state.isAutoDispatched ? 'Dispatched ✓' : 'Auto-\nDispatch',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, height: 1.1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Section 3: Long-term Preventive Infrastructure Plan
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.build_outlined, color: CivicColors.primary, size: 15),
                        SizedBox(width: 6),
                        Text(
                          'Long-term Preventive\nInfrastructure Plan',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: CivicColors.primary,
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '3 Strategic\nVectors',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: CivicColors.primary,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildVectorItem(
                  1,
                  'Subterranean Hydraulic Bin\nInstallation',
                  'Estimated budget ₹1.8L under PWD\nWard Improvement Fund FY25.',
                  isDark,
                ),
                const SizedBox(height: 10),
                _buildVectorItem(
                  2,
                  'AI Rekognition Sensor\nRepositioning',
                  'Tilt North Corridor pole camera angle\n14° south to eliminate blind spot.',
                  isDark,
                ),
                const SizedBox(height: 10),
                _buildVectorItem(
                  3,
                  'Sanitation Shift Rescheduling',
                  'Shift pickup window from 15:00 to\n11:30 AM before peak campus\ndispersal.',
                  isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Required Human Authorization Boundaries
          Row(
            children: const [
              Icon(Icons.shield_outlined, size: 14, color: CivicColors.textSecondaryLight),
              SizedBox(width: 6),
              Text(
                'Required Human Authorization Boundaries',
                style: TextStyle(fontSize: 10.5, color: CivicColors.textSecondaryLight),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Main Approve Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: state.isPwdApproved ? CivicColors.mintDark : CivicColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(state.isPwdApproved ? Icons.check_circle : Icons.send_rounded, size: 18),
              label: Text(
                state.isPwdApproved ? 'Approved & Routed to PWD Works' : 'Approve & Route to PWD Works Dept',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                state.approvePwdRouting();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: CivicColors.mintDark,
                    content: Text('✅ Requisition routed to PWD Works Dept for FY25 Fund Allocation.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Secondary Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
                    foregroundColor: CivicColors.primary,
                    side: BorderSide(color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.campaign_outlined, size: 16),
                  label: const Text(
                    'Draft Citizen Not...',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Drafted Notice: "Municipal Preventive Maintenance at DTU North Gate scheduled."'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
                    foregroundColor: CivicColors.primary,
                    side: BorderSide(color: isDark ? CivicColors.borderDark : const Color(0xFFC7D2FE)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: const Text(
                    'Export Summary',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Exported PDF Brief: Bedrock_Triage_Ward42.pdf to Downloads.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVectorItem(int num, String title, String desc, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: CivicColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$num',
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. Ward 42 Preventive Hotspot Ledger
  Widget _buildHotspotLedgerSection(BuildContext context, CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.warning_amber_rounded, color: CivicColors.primary, size: 18),
                SizedBox(width: 6),
                Text(
                  'Ward 42 Preventive\nHotspot Ledger',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: CivicColors.textPrimaryLight,
                    height: 1.15,
                  ),
                ),
              ],
            ),
            const Text(
              'Live Predictive\nTriage',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: CivicColors.textSecondaryLight,
                height: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...state.hotspots.map((hotspot) => _buildHotspotCard(context, state, hotspot, isDark)),
      ],
    );
  }

  Widget _buildHotspotCard(BuildContext context, CivicAppState state, HotspotLedgerItemModel hotspot, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          // Row 1: Title & Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  hotspot.id.contains('sec16') ? Icons.location_on_outlined : Icons.layers_outlined,
                  color: CivicColors.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotspot.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      hotspot.locationSubtext,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: hotspot.id.contains('sec16') ? const Color(0xFFEEF2FF) : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  hotspot.badgeText,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: hotspot.id.contains('sec16') ? CivicColors.primary : const Color(0xFF991B1B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: Scheduled box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      hotspot.id.contains('sec16') ? Icons.alt_route : Icons.calendar_today_outlined,
                      size: 14,
                      color: CivicColors.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      hotspot.scheduleTitle,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    hotspot.scheduleEta,
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: CivicColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Row 3: Telemetry & Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  hotspot.telemetryText,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  state.dispatchHotspot(hotspot.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: CivicColors.mintDark,
                      content: Text('Dispatched squad to ${hotspot.title}!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text(
                  hotspot.isDispatched ? 'Dispatched ✓' : hotspot.actionButtonText,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: hotspot.isDispatched ? CivicColors.mintDark : CivicColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Dynamic Live Chat History
  Widget _buildChatHistory(CivicAppState state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live Copilot Session',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 8),
        ...state.copilotMessages.map((msg) {
          final isUser = msg.sender == 'user';
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
              decoration: BoxDecoration(
                color: isUser
                    ? CivicColors.primary
                    : (isDark ? CivicColors.cardDark : const Color(0xFFEEF2FF)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: msg.isGenerating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(color: CivicColors.primary, strokeWidth: 2),
                    )
                  : Text(
                      msg.text,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: isUser ? Colors.white : (isDark ? Colors.white : CivicColors.textPrimaryLight),
                        height: 1.3,
                      ),
                    ),
            ),
          );
        }),
      ],
    );
  }

  // 6. Floating Copilot Input Bar
  Widget _buildBottomInputBar(CivicAppState state, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        border: Border(
          top: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Mic Icon Button
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.mic_none_outlined, color: CivicColors.primary, size: 20),
              ),
            ),
            const SizedBox(width: 10),

            // Text Input
            Expanded(
              child: TextField(
                controller: _queryController,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                ),
                decoration: InputDecoration(
                  hintText: 'Ask Bedrock Copilot about Ward 42...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                  ),
                  filled: true,
                  fillColor: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                  ),
                ),
                onSubmitted: (val) => _sendQuery(state, val),
              ),
            ),
            const SizedBox(width: 8),

            // Send Arrow Button (Solid Purple)
            GestureDetector(
              onTap: () => _sendQuery(state, _queryController.text),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: CivicColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
