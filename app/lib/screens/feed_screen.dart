import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import 'report_hazard_modal.dart';
import 'grievance_detail_screen.dart'; // We'll create this next

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

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
              // 1. Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
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
                            Row(
                              children: [
                                Text(
                                  'CLEANCITY ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? Colors.white : CivicColors.primaryDark,
                                  ),
                                ),
                                Text(
                                  '| Home',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CivicColors.textSecondaryLight,
                                  ),
                                ),
                              ],
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
                                  'Ward GPS Live',
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
                                child: const Text(
                                  'EN',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: const BoxDecoration(color: Colors.transparent),
                                child: const Text(
                                  'हि',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.textSecondaryLight),
                                ),
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

              // 2. Profile Intro
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? CivicColors.cardDark : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.verified_user_outlined, size: 14, color: CivicColors.primary),
                            SizedBox(width: 6),
                            Text(
                              'CIVIC CITIZEN PROFILE',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primary),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: CivicColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text('EN', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w800)),
                              ),
                              const SizedBox(width: 4),
                              const Text('हि', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
                              const SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Namaste, Priya ...',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, size: 14, color: CivicColors.primaryDark),
                        SizedBox(width: 4),
                        Text(
                          'Ward 142, Indiranagar, Bengaluru',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 3. Main Action Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [CivicColors.primary, CivicColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CivicColors.primary.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 24),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text('Smart Ward AI 2.0', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Report a Problem',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                    const Text(
                      'समस्या दर्ज करें',
                      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'AI auto-detects waste category & ward in\nseconds',
                      style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: CivicColors.primaryDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                        label: const Text(
                          'Tap to Capture Grievance / फोटो खींचें',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReportHazardModal()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 4. Quick Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Quick Categories / श्रेणियां',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                    Text(
                      'TAP TO REPORT',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.delete_outline,
                            iconColor: CivicColors.primaryDark,
                            iconBgColor: const Color(0xFFA7F3D0), // emerald-200
                            title: 'Garbage Du...',
                            subtitle: 'कचरा ढेर',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.checklist_rtl,
                            iconColor: const Color(0xFF0F172A),
                            iconBgColor: const Color(0xFFE2E8F0), // slate-200
                            title: 'Overflowing...',
                            subtitle: 'भरा हुआ कूड़ादान',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.local_fire_department_outlined,
                            iconColor: const Color(0xFF92400E), // amber-800
                            iconBgColor: const Color(0xFFFDE68A), // amber-200
                            title: 'Waste Burning',
                            subtitle: 'कचरा जलाना',
                            badge: 'Urgent',
                            badgeColor: const Color(0xFFB45309), // amber-700
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.home_outlined,
                            iconColor: const Color(0xFF334155),
                            iconBgColor: const Color(0xFFE2E8F0),
                            title: 'Drain Blocked',
                            subtitle: 'नाली जाम',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.handyman_outlined,
                            iconColor: const Color(0xFF0F172A),
                            iconBgColor: const Color(0xFFE2E8F0),
                            title: 'Construction',
                            subtitle: 'मलवे का ढेर',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildCategoryCard(
                            icon: Icons.play_arrow_rounded, // chemical icon placeholder
                            iconColor: Colors.white,
                            iconBgColor: const Color(0xFFBE123C), // rose-700
                            title: 'Chemical',
                            titleColor: const Color(0xFFBE123C),
                            subtitle: 'रासायनिक कचरा',
                            badge: 'High Risk',
                            badgeColor: const Color(0xFFBE123C), // rose-700
                            bgColor: const Color(0xFFFFE4E6), // pink-100
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 5. Your Latest Report
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Your Latest Report / आपकी रिपोर्ट',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                    ),
                    Text(
                      'View All (4)',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GrievanceDetailScreen()),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '#CC-84920',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFA7F3D0), // emerald-200
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Overflowing Bin',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF065F46)), // emerald-800
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7), // amber-100
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.circle, color: Color(0xFFD97706), size: 6), // amber-600
                                SizedBox(width: 4),
                                Text(
                                  'In Progress / काम जारी',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF92400E)), // amber-800
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    'overflowing_dumpster_1791533637321.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    left: 4,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      decoration: BoxDecoration(
                                        color: CivicColors.primaryDark,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.check_circle, color: Colors.white, size: 8),
                                          SizedBox(width: 2),
                                          Text('96% AI', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF475569)),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        '12th Main Road, Near Metro Pillar 84',
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: const [
                                    Icon(Icons.timer_outlined, size: 12, color: Color(0xFFB45309)), // amber-700
                                    SizedBox(width: 4),
                                    Text('Resolving within ', style: TextStyle(fontSize: 10, color: Color(0xFF475569))),
                                    Text('2h 45m', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFFB45309))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Assigned: BBMP Sanitation Squad 14',
                                  style: TextStyle(fontSize: 9, color: Color(0xFF64748B)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: CivicColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Submitted 08:30 AM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                          Text('SLA On-Track', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: CivicColors.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 6. Swachh Ward Impact
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: CivicColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7F3D0), // emerald-200
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.emoji_events_outlined, color: Color(0xFF047857), size: 24), // emerald-700
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'SWACHH WARD IMPACT',
                                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6EE7B7), // emerald-300
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text('Ward 142', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Color(0xFF064E3B))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '1,240 complaints resolved in your ward this month!',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.2),
                              ),
                              const SizedBox(height: 6),
                              RichText(
                                text: const TextSpan(
                                  text: '98.4%',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: CivicColors.primary),
                                  children: [
                                    TextSpan(
                                      text: ' cleared within municipal SLA timelines.',
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF475569)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 7. Ward Supervisor Contact
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF2FF), // indigo-50
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.support_agent_outlined, color: Color(0xFF312E81), size: 16), // indigo-900
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ward Supervisor Contact', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                          Text('K. Suresh (East Zone Zone-Officer)', style: TextStyle(fontSize: 10, color: Color(0xFF475569))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9), // slate-100
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.call_outlined, size: 14, color: CivicColors.primaryDark),
                          SizedBox(width: 4),
                          Text('Call Desk', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primaryDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    Color titleColor = const Color(0xFF0F172A),
    Color bgColor = const Color(0xFFF8FAFC),
    String? badge,
    Color? badgeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: titleColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: titleColor == const Color(0xFF0F172A) ? const Color(0xFF475569) : titleColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (badge != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 8),
                        const SizedBox(width: 4),
                        Text(badge, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
