import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';

class SystemWorkflowSheet extends StatefulWidget {
  const SystemWorkflowSheet({super.key});

  @override
  State<SystemWorkflowSheet> createState() => _SystemWorkflowSheetState();
}

class _SystemWorkflowSheetState extends State<SystemWorkflowSheet> {
  int _selectedNodeIndex = -1;
  bool _isSimulating = false;
  int _simulationStep = 0;

  final List<Map<String, dynamic>> _nodes = [
    {
      'id': 'otp_login',
      'title': 'OTP login',
      'lane': 'Citizen',
      'colorType': 'citizen',
      'tech': 'AWS Cognito MFA + DynamoDB Users',
      'desc': 'Citizens authenticate via 6-digit SMS OTP (+91 numbers). No passwords required. Grants encrypted JWT session token.',
      'rule': 'Live camera reports and karma accumulation require authenticated session.',
    },
    {
      'id': 'live_photo_report',
      'title': 'Live photo\nreport',
      'lane': 'Citizen',
      'colorType': 'citizen',
      'tech': 'Camera API + S3 Pre-signed URL',
      'desc': 'Forces live in-app camera capture with hardware GPS lock & EXIF timestamp sign. Gallery file uploads are strictly blocked.',
      'rule': 'Gallery uploads blocked at OS level to prevent fabricated reporting.',
    },
    {
      'id': 'fake_check_ai_detect',
      'title': 'Fake check\n+ AI detect',
      'lane': 'System + AI',
      'colorType': 'ai',
      'tech': 'AWS Rekognition + Perceptual Hash (pHash)',
      'desc': 'Computes 64-bit DCT perceptual hash to prevent recycled images. Rekognition detects garbage dumps, overflows, silt, and debris with 0-100 severity.',
      'rule': 'Images within 120s duplicate hash window are automatically rejected.',
    },
    {
      'id': 'merge_dupes_sla_timer',
      'title': 'Merge dupes\n+ SLA timer',
      'lane': 'System + AI',
      'colorType': 'ai',
      'tech': 'PostGIS Proximity Query + EventBridge SLA Clock',
      'desc': 'If a report is submitted within 50m of an existing open issue, it merges as a community upvote (+10 KP to citizen). Starts 45m SLA timer.',
      'rule': 'Prevents multiple redundant tickets while increasing priority weighting.',
    },
    {
      'id': 'alert_task_list',
      'title': 'Alert +\ntask list',
      'lane': 'Field worker',
      'colorType': 'worker',
      'tech': 'FCM Push Notifications + Geofenced Task Queue',
      'desc': 'Dispatches instant push alerts to field units (e.g. Unit #3). Daily tasks are sorted by SLA deadline and distance.',
      'rule': 'Worker must acknowledge within 10 minutes or ticket begins escalation tier.',
    },
    {
      'id': 'fix_take_after_photo',
      'title': 'Fix + take\nafter photo',
      'lane': 'Field worker',
      'colorType': 'worker',
      'tech': 'Amazon Location Service Geofence + Live Proof Camera',
      'desc': 'Worker arrives on-site, executes cleanup/desilting, and takes a live after-photo within a 50m geofence radius of original incident.',
      'rule': 'Resolution cannot be submitted outside geofenced boundary.',
    },
    {
      'id': 'escalate_sla_miss',
      'title': 'Escalate\non SLA miss',
      'lane': 'Officers',
      'colorType': 'officers',
      'tech': 'AWS Step Functions + SNS Alert Router',
      'desc': 'If task is not completed within 75% of SLA deadline or timer expires, system auto-escalates to Zonal Inspector & Municipal Commissioner.',
      'rule': 'Triggers high-priority executive alerts and red flags on supervisor dashboard.',
    },
    {
      'id': 'ai_verify_after_photo',
      'title': 'AI verify\nafter photo',
      'lane': 'System + AI',
      'colorType': 'ai',
      'tech': 'AWS Rekognition Visual Difference Engine',
      'desc': 'Compares before and after images for debris removal and cleanliness. Requires diff score ≥ 85% to automatically approve resolution.',
      'rule': 'Diff scores < 85% redirect ticket to Executive Manual Review Queue.',
    },
    {
      'id': 'status_rewards',
      'title': 'Status +\nrewards',
      'lane': 'Citizen',
      'colorType': 'citizen',
      'tech': 'DynamoDB Ledger + Karma Points Engine',
      'desc': 'Citizen report status updates to "Verified". Credits +25 Karma Points, boosts Trust Score, and updates Ward Leaderboard.',
      'rule': 'Points are redeemable for DTC Bus and Delhi Metro civic travel passes.',
    },
    {
      'id': 'heatmap_ai_summary',
      'title': 'Heatmap +\nAI summary',
      'lane': 'Officers',
      'colorType': 'officers',
      'tech': 'Amazon Bedrock Claude 3 + MapLibre GIS Heatmap',
      'desc': 'Synthesizes ward resolution data into GIS hotspot intensity maps and generates executive root cause briefs for municipal leadership.',
      'rule': 'Provides real-time predictive analytics on recurrent waste dump areas.',
    },
  ];

  void _runSimulation() async {
    setState(() {
      _isSimulating = true;
      _simulationStep = 0;
      _selectedNodeIndex = 0;
    });

    for (int i = 0; i < _nodes.length; i++) {
      if (!mounted) return;
      setState(() {
        _simulationStep = i;
        _selectedNodeIndex = i;
      });
      await Future.delayed(const Duration(milliseconds: 1400));
    }

    if (mounted) {
      setState(() {
        _isSimulating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 10),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CivicColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.account_tree_rounded, color: CivicColors.primary, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CivicPulse Architecture Workflow',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        '4-Swimlane Real-Time Incident Lifecycle',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSimulating ? Colors.orange : CivicColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: Icon(_isSimulating ? Icons.hourglass_top : Icons.play_arrow, size: 16),
                  label: Text(
                    _isSimulating ? 'Step ${_simulationStep + 1}/10' : 'Simulate',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                  onPressed: _isSimulating ? null : _runSimulation,
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 16),

          // Main Diagram Viewport
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // Visual Diagram Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Swimlane 1: Citizen
                        _buildSwimlaneRow(
                          laneTitle: 'Citizen',
                          isDark: isDark,
                          children: [
                            _buildWorkflowNode(
                              index: 0,
                              title: 'OTP\nlogin',
                              colorType: 'citizen',
                              isDark: isDark,
                            ),
                            _buildSolidArrow(direction: ArrowDir.right),
                            _buildWorkflowNode(
                              index: 1,
                              title: 'Live photo\nreport',
                              colorType: 'citizen',
                              isDark: isDark,
                            ),
                            const Spacer(),
                            _buildWorkflowNode(
                              index: 8,
                              title: 'Status +\nrewards',
                              colorType: 'citizen',
                              isDark: isDark,
                            ),
                          ],
                        ),

                        // Connector Row 1 -> 2: (Live photo report -> Fake check) & (AI verify -> Status + rewards)
                        _buildConnectorRow(
                          leftContent: Row(
                            children: [
                              const SizedBox(width: 140),
                              _buildDownArrow(color: const Color(0xFF94A3B8)),
                            ],
                          ),
                          rightContent: Row(
                            children: [
                              const Spacer(),
                              _buildUpArrow(color: const Color(0xFF94A3B8)),
                              const SizedBox(width: 28),
                            ],
                          ),
                        ),

                        // Swimlane 2: System + AI
                        _buildSwimlaneRow(
                          laneTitle: 'System\n+ AI',
                          isDark: isDark,
                          children: [
                            const SizedBox(width: 75),
                            _buildWorkflowNode(
                              index: 2,
                              title: 'Fake check\n+ AI detect',
                              colorType: 'ai',
                              isDark: isDark,
                            ),
                            _buildSolidArrow(direction: ArrowDir.right),
                            _buildWorkflowNode(
                              index: 3,
                              title: 'Merge dupes\n+ SLA timer',
                              colorType: 'ai',
                              isDark: isDark,
                            ),
                            const Spacer(),
                            _buildWorkflowNode(
                              index: 7,
                              title: 'AI verify\nafter photo',
                              colorType: 'ai',
                              isDark: isDark,
                            ),
                          ],
                        ),

                        // Connector Row 2 -> 3: (Merge dupes -> Alert) & (Fix photo -> AI verify)
                        _buildConnectorRow(
                          leftContent: Row(
                            children: [
                              const SizedBox(width: 215),
                              _buildDownArrow(color: const Color(0xFF94A3B8)),
                            ],
                          ),
                          rightContent: Row(
                            children: [
                              const Spacer(),
                              _buildUpArrow(color: const Color(0xFF94A3B8)),
                              const SizedBox(width: 28),
                            ],
                          ),
                        ),

                        // Swimlane 3: Field worker
                        _buildSwimlaneRow(
                          laneTitle: 'Field\nworker',
                          isDark: isDark,
                          children: [
                            const SizedBox(width: 180),
                            _buildWorkflowNode(
                              index: 4,
                              title: 'Alert +\ntask list',
                              colorType: 'worker',
                              isDark: isDark,
                            ),
                            _buildSolidArrow(direction: ArrowDir.right),
                            _buildWorkflowNode(
                              index: 5,
                              title: 'Fix + take\nafter photo',
                              colorType: 'worker',
                              isDark: isDark,
                            ),
                            const Spacer(),
                          ],
                        ),

                        // Connector Row 3 -> 4: (Alert -> Escalate dashed) & (AI verify -> Heatmap)
                        _buildConnectorRow(
                          leftContent: Row(
                            children: [
                              const SizedBox(width: 215),
                              _buildDashedDownArrow(color: const Color(0xFF94A3B8)),
                            ],
                          ),
                          rightContent: Row(
                            children: [
                              const Spacer(),
                              _buildDownArrow(color: const Color(0xFF94A3B8)),
                              const SizedBox(width: 28),
                            ],
                          ),
                        ),

                        // Swimlane 4: Officers
                        _buildSwimlaneRow(
                          laneTitle: 'Officers',
                          isDark: isDark,
                          children: [
                            const SizedBox(width: 180),
                            _buildWorkflowNode(
                              index: 6,
                              title: 'Escalate\non SLA miss',
                              colorType: 'officers',
                              isDark: isDark,
                            ),
                            const Spacer(),
                            _buildWorkflowNode(
                              index: 9,
                              title: 'Heatmap +\nAI summary',
                              colorType: 'officers',
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Selected Node Deep Dive Card
                  if (_selectedNodeIndex >= 0 && _selectedNodeIndex < _nodes.length)
                    _buildNodeInspector(_nodes[_selectedNodeIndex], isDark)
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.touch_app_outlined, color: CivicColors.primary, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Tap any node above or click "Simulate" to inspect the architectural logic, AWS services, and fraud detection rules.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),

                  // End-to-End System Checklist
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: CivicColors.mintDark, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Verified System Capabilities Matrix',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildCapabilityItem('Citizen: Mobile OTP Login (Cognito MFA, +91 format, no password)', isDark),
                        _buildCapabilityItem('Citizen: Live Camera Only (Hardware GPS lock, gallery upload blocked)', isDark),
                        _buildCapabilityItem('Citizen: Status Timeline (Reported ➔ Assigned ➔ In Progress ➔ Resolved ➔ Verified)', isDark),
                        _buildCapabilityItem('AI: Fake Check & Anti-Fraud (Perceptual hash + EXIF timestamp lock)', isDark),
                        _buildCapabilityItem('AI: Object Detection & Severity 0-100 (High near schools/hospitals)', isDark),
                        _buildCapabilityItem('AI: Proximity Duplicate Merge (50m radius upvote, no ticket bloat)', isDark),
                        _buildCapabilityItem('Worker: SLA-Sorted Task List with real-time countdown alerts', isDark),
                        _buildCapabilityItem('Worker: Geofenced Proof Resolution (Live after-photo <50m of site)', isDark),
                        _buildCapabilityItem('AI: Automated Before/After Rekognition Diff Check (≥85% threshold)', isDark),
                        _buildCapabilityItem('Citizen: Karma Rewards (+25 KP) & Trust Score Boost', isDark),
                        _buildCapabilityItem('Officers: Automated SLA Escalation (75% threshold & timeout trigger)', isDark),
                        _buildCapabilityItem('Officers: GIS Hotspot Heatmap & Bedrock Claude 3 Executive Summary', isDark),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwimlaneRow({
    required String laneTitle,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A).withOpacity(0.5) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              laneTitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white70 : const Color(0xFF1E293B),
                height: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowNode({
    required int index,
    required String title,
    required String colorType,
    required bool isDark,
  }) {
    final isSelected = _selectedNodeIndex == index;
    final isSimulatingThis = _isSimulating && _simulationStep == index;

    // Colors matching user diagram exactly:
    // Citizen & Worker: Peach/Rose `#FDF2F0` with border `#E8B4AC` and text `#8C3A27`
    // AI: Lavender `#EEF0FF` with border `#C6CBFA` and text `#4F46E5`
    // Officers: Mint `#E6F7F0` with border `#A3E2C9` and text `#0F766E`

    Color bgColor;
    Color borderColor;
    Color textColor;

    switch (colorType) {
      case 'ai':
        bgColor = isDark ? const Color(0xFF1E1B4B) : const Color(0xFFEEF0FF);
        borderColor = isDark ? const Color(0xFF6366F1) : const Color(0xFFC6CBFA);
        textColor = isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4338CA);
        break;
      case 'officers':
        bgColor = isDark ? const Color(0xFF064E3B) : const Color(0xFFE6F7F0);
        borderColor = isDark ? const Color(0xFF10B981) : const Color(0xFFA3E2C9);
        textColor = isDark ? const Color(0xFF6EE7B7) : const Color(0xFF0F766E);
        break;
      case 'worker':
      case 'citizen':
      default:
        bgColor = isDark ? const Color(0xFF451A03) : const Color(0xFFFDF2F0);
        borderColor = isDark ? const Color(0xFFF97316) : const Color(0xFFE8B4AC);
        textColor = isDark ? const Color(0xFFFDBA74) : const Color(0xFF8C3A27);
        break;
    }

    if (isSelected || isSimulatingThis) {
      borderColor = isDark ? Colors.white : Colors.black87;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNodeIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 82,
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: (isSelected || isSimulatingThis) ? 2.2 : 1.2,
          ),
          boxShadow: (isSelected || isSimulatingThis)
              ? [
                  BoxShadow(
                    color: borderColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
              height: 1.15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSolidArrow({required ArrowDir direction}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(
        direction == ArrowDir.right ? Icons.arrow_forward : Icons.arrow_downward,
        size: 14,
        color: const Color(0xFF94A3B8),
      ),
    );
  }

  Widget _buildConnectorRow({required Widget leftContent, required Widget rightContent}) {
    return SizedBox(
      height: 18,
      child: Row(
        children: [
          const SizedBox(width: 80),
          Expanded(
            child: Stack(
              children: [
                leftContent,
                rightContent,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownArrow({required Color color}) {
    return Icon(Icons.arrow_downward, size: 14, color: color);
  }

  Widget _buildUpArrow({required Color color}) {
    return Icon(Icons.arrow_upward, size: 14, color: color);
  }

  Widget _buildDashedDownArrow({required Color color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 1.5, height: 3, color: color),
        const SizedBox(height: 2),
        Container(width: 1.5, height: 3, color: color),
        Icon(Icons.arrow_downward, size: 11, color: color),
      ],
    );
  }

  Widget _buildNodeInspector(Map<String, dynamic> node, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CivicColors.primary.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: CivicColors.primary.withOpacity(0.08),
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
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: CivicColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      node['lane'].toString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    node['title'].toString().replaceAll('\n', ' '),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => setState(() => _selectedNodeIndex = -1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.developer_board, size: 14, color: CivicColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    node['tech'] ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: CivicColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            node['desc'] ?? '',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_outlined, size: 14, color: CivicColors.mintDark),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Enforced Rule: ${node['rule']}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? CivicColors.mint : CivicColors.mintDark,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapabilityItem(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 15, color: CivicColors.mintDark),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11.5,
                color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ArrowDir { right, down }
