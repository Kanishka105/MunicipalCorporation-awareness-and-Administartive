import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GrievanceDetailScreen extends StatelessWidget {
  const GrievanceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? CivicColors.bgDark : const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, size: 20),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: CivicColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.eco, color: Colors.white, size: 10),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grievance Detail',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: CivicColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Ward Active',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? CivicColors.textPrimaryDark : CivicColors.textPrimaryLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: CivicColors.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('EN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: const BoxDecoration(color: Colors.transparent),
                                child: Text('हि', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.textSecondaryLight)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFE4E6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.diamond_outlined, color: Color(0xFFE11D48), size: 16),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: CivicColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2. Sub Header (Ticket ID & Actions)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text('#CC-84920', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primaryDark)),
                        Text(' • Ward 142 • Indiranagar', style: TextStyle(fontSize: 10, color: Color(0xFF475569))),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                          child: const Icon(Icons.share_outlined, size: 14, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                          child: const Icon(Icons.notifications_none, size: 14, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 3. Image Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'overflowing_dumpster_1791533637321.jpg',
                              fit: BoxFit.cover,
                            ),
                            // Top Left Pill
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD97706), // amber-600
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.warning_amber_rounded, color: Colors.white, size: 12),
                                    SizedBox(width: 4),
                                    Text('High Severity / उच्च प्राथमिकता', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                            // Top Right Pill
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('12th Main Road', style: TextStyle(color: Color(0xFF0F172A), fontSize: 9, fontWeight: FontWeight.w800)),
                              ),
                            ),
                            // AI Boxes
                            Positioned(
                              top: 60,
                              left: 60,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD97706).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.center_focus_strong, color: Colors.white, size: 10),
                                    SizedBox(width: 4),
                                    Text('BBMP-AI: Spill Box #01', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              right: 80,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('94.2%', style: TextStyle(color: Color(0xFF0F172A), fontSize: 8, fontWeight: FontWeight.w800)),
                              ),
                            ),
                            // Bounding box placeholder
                            Center(
                              child: Container(
                                width: 200,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFFCD34D), width: 1.5), // amber-300
                                  color: const Color(0xFFFCD34D).withOpacity(0.1),
                                ),
                              ),
                            ),
                            // Bottom Pill row
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(12)), // light blue
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete_outline, color: Color(0xFF0369A1), size: 10),
                                        SizedBox(width: 4),
                                        Text('Overflow 94%', style: TextStyle(color: Color(0xFF0369A1), fontSize: 9, fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(color: const Color(0xFFFFEDD5), borderRadius: BorderRadius.circular(12)), // orange-100
                                    child: Row(
                                      children: const [
                                        Icon(Icons.category_outlined, color: Color(0xFF9A3412), size: 10),
                                        SizedBox(width: 4),
                                        Text('Mixed Plastic 88%', style: TextStyle(color: Color(0xFF9A3412), fontSize: 9, fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -2,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                margin: const EdgeInsets.only(top: 24), // visually stacked under previous row
                                decoration: BoxDecoration(color: const Color(0xFFFFE4E6), borderRadius: BorderRadius.circular(12)), // pink-100
                                child: Row(
                                  children: const [
                                    Icon(Icons.warning_amber_rounded, color: Color(0xFFBE123C), size: 10),
                                    SizedBox(width: 4),
                                    Text('Pedestrian Hazard', style: TextStyle(color: Color(0xFFBE123C), fontSize: 9, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF), // indigo-50
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.camera_alt_outlined, color: CivicColors.primaryDark, size: 14),
                                  SizedBox(width: 6),
                                  Text('Initial Report', style: TextStyle(color: CivicColors.primaryDark, fontSize: 11, fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.image_outlined, color: Color(0xFF475569), size: 14),
                                  SizedBox(width: 6),
                                  Text('Current State', style: TextStyle(color: Color(0xFF475569), fontSize: 11, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 4. SLA Box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.timer_outlined, size: 14, color: Color(0xFF0F172A)),
                            SizedBox(width: 6),
                            Text('Municipal SLA Countdown', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7F3D0), // emerald-200
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('ON-TRACK', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('2h 45m remaining', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: CivicColors.primaryDark)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 68,
                          child: Container(height: 6, decoration: const BoxDecoration(color: CivicColors.primary, borderRadius: BorderRadius.horizontal(left: Radius.circular(3)))),
                        ),
                        Expanded(
                          flex: 32,
                          child: Container(height: 6, decoration: const BoxDecoration(color: Color(0xFFE2E8F0), borderRadius: BorderRadius.horizontal(right: Radius.circular(3)))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Target Window: 6 Hours', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                        Text('68% Elapsed', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: CivicColors.primaryDark,
                              shape: BoxShape.circle,
                            ),
                            child: const Text('MR', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Officer M. Raghavan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                Text('BBMP Sanitation Squad #14', style: TextStyle(fontSize: 10, color: Color(0xFF475569))),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: const Icon(Icons.call_outlined, size: 16, color: CivicColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 5. Audit Trail
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Grievance Audit Trail', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('Updated 4m ago', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildAuditStep(
                      icon: Icons.check,
                      iconBg: const Color(0xFFA7F3D0), // emerald-200
                      iconColor: const Color(0xFF047857), // emerald-700
                      title: 'Reported',
                      time: '08:30 AM',
                      subtitle: 'दर्ज किया गया • Oct 24',
                      description: 'Submitted via CleanCity Citizen Portal with GPS geotag lock.',
                      isLast: false,
                    ),
                    _buildAuditStep(
                      icon: Icons.smart_toy_outlined,
                      iconBg: const Color(0xFFA7F3D0),
                      iconColor: const Color(0xFF047857),
                      title: 'AI Verified',
                      time: '08:32 AM',
                      subtitle: 'एआई द्वारा सत्यापित • Oct 24',
                      isLast: false,
                      pills: ['94% Confidence', 'Auto-Categorized'],
                    ),
                    _buildAuditStep(
                      icon: Icons.assignment_ind_outlined,
                      iconBg: const Color(0xFFA7F3D0),
                      iconColor: const Color(0xFF047857),
                      title: 'Assigned',
                      time: '09:15 AM',
                      subtitle: 'अधिकारी नियुक्त • Oct 24',
                      description: 'Squad 14 auto-routed under East Zone Solid Waste Directive.',
                      isLast: false,
                    ),
                    _buildAuditStep(
                      icon: Icons.hourglass_top,
                      iconBg: const Color(0xFF92400E), // amber-800
                      iconColor: Colors.white,
                      title: 'In Progress',
                      time: 'Active',
                      timeBg: const Color(0xFFFDE68A), // amber-200
                      timeColor: const Color(0xFF92400E),
                      subtitle: 'सफाई जारी है • Transit Phase',
                      description: 'Compactor Truck KA-04-G-8821 in transit to location point.',
                      isLast: false,
                      lineColor: const Color(0xFFCBD5E1), // slate-300
                    ),
                    _buildAuditStep(
                      icon: Icons.check_circle_outline,
                      iconBg: Colors.transparent,
                      iconColor: const Color(0xFF94A3B8), // slate-400
                      iconBorder: const Color(0xFF94A3B8),
                      title: 'Resolved & Cleaned',
                      titleColor: const Color(0xFF64748B),
                      time: 'Pending',
                      timeColor: const Color(0xFF94A3B8),
                      subtitle: 'सफलतापूर्वक निस्तारित',
                      subtitleColor: const Color(0xFF94A3B8),
                      description: 'Pending physical post-cleanup evidence and QA geotag.',
                      descColor: const Color(0xFF94A3B8),
                      isLast: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 6. Coordinates Map
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14, color: CivicColors.primaryDark),
                            SizedBox(width: 6),
                            Text('Incident Coordinates', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                          ],
                        ),
                        Text('12.9784° N, 77.6408° E', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primaryDark, fontFamily: 'monospace')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&w=600&q=80', // placeholder map
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.change_history, size: 12, color: CivicColors.primary),
                                    SizedBox(width: 4),
                                    Text('Corner of 12th Main & 4th Cross Road', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 7. Neighbors Verified
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFA7F3D0), // emerald-200
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.thumb_up_alt_outlined, color: Color(0xFF047857), size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('42 Neighbors Verified', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                          Text('Upvoted in Ward 142 grievance feed', style: TextStyle(fontSize: 10, color: Color(0xFF475569))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add, size: 12, color: CivicColors.primaryDark),
                          SizedBox(width: 4),
                          Text('Confirm', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primaryDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // spacing for bottom bar
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CivicColors.primaryDark,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.add_comment_outlined, size: 16),
                  label: const Text('Add a Suggestion / टिप्पणी जोड़ें', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE4E6), // pink-100
                    foregroundColor: const Color(0xFFE11D48), // rose-600
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.headset_mic_outlined, size: 16),
                  label: const Text('Call 1913', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditStep({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    Color? iconBorder,
    required String title,
    required String time,
    required String subtitle,
    String? description,
    required bool isLast,
    List<String>? pills,
    Color titleColor = const Color(0xFF0F172A),
    Color timeColor = const Color(0xFF0F172A),
    Color? timeBg,
    Color subtitleColor = const Color(0xFF475569),
    Color descColor = const Color(0xFF1E293B),
    Color lineColor = const Color(0xFF059669), // emerald-600
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Column
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                  border: iconBorder != null ? Border.all(color: iconBorder) : null,
                ),
                child: Icon(icon, size: 12, color: iconColor),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: lineColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Content Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: titleColor)),
                      if (timeBg != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: timeBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(time, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: timeColor)),
                        )
                      else
                        Text(time, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: timeColor)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: subtitleColor)),
                  if (description != null) ...[
                    const SizedBox(height: 6),
                    Text(description, style: TextStyle(fontSize: 10.5, color: descColor, height: 1.3)),
                  ],
                  if (pills != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: pills.map((p) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF), // indigo-50
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(p, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF312E81))),
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
