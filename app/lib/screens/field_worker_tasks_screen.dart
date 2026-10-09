import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import 'task_resolution_screen.dart';

class FieldWorkerTasksScreen extends StatelessWidget {
  const FieldWorkerTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
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
                        const Icon(Icons.arrow_back, size: 20),
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
                              'Field Worker T...',
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
                                child: const Text(
                                  'EN',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
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
                            color: Color(0xFFFFE4E6), // pink-100
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

              // 2. Sub Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BBMP EAST ZONE • SQUAD #14',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: CivicColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Field Worker Ta...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            letterSpacing: -0.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7F3D0), // emerald-200
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF047857), // emerald-700
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'On Duty (08:00 - 16:00)',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF065F46), // emerald-800
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 16, color: CivicColors.textPrimaryLight),
                            const SizedBox(width: 6),
                            const Text(
                              'Tuesday, 24 Oct • 8 Pending\nTasks',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: CivicColors.textPrimaryLight,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF), // indigo-100
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Indiranagar\nEast',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF312E81), // indigo-900
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 3. Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildFilterPill('All (8)', isSelected: true, countIndicator: null),
                    const SizedBox(width: 8),
                    _buildFilterPill('Due Soon', isSelected: false, countIndicator: '3', countColor: const Color(0xFFFDE68A)),
                    const SizedBox(width: 8),
                    _buildFilterPill('Overdue', isSelected: false, countIndicator: '1', countColor: const Color(0xFFFECDD3)),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 4. Urgent SLA Violation Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E6), // pink-100
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Color(0xFFBE123C), size: 24), // rose-700
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '1 Urgent SLA Violation Imminent',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFBE123C), // rose-700
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Hazmat ticket requires immediate containment protocol.',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9F1239), // rose-800
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 5. Tasks List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildTaskCard(
                      context,
                      bannerColor: const Color(0xFFB91C1C), // red-700
                      bannerText: '1h 15m remaining (CRITICAL)',
                      pillColor: const Color(0xFFFECDD3), // red-200
                      pillText: 'CRITICAL / गंभीर',
                      imageUrl: 'drain_silt_hazard_1791533703667.jpg',
                      ticketId: '#HZ-108',
                      hazardIcon: Icons.emergency_outlined,
                      hazardIconColor: const Color(0xFFDC2626), // red-600
                      title: 'Chemical Spill / Haz...',
                      location: '8th Cross, 100ft Road, Near K...',
                      distance: '450 m away (6 mins)',
                      distanceColor: const Color(0xFF047857), // emerald-700
                      status: 'Assigned',
                    ),
                    const SizedBox(height: 16),
                    _buildTaskCard(
                      context,
                      bannerColor: const Color(0xFFB45309), // amber-700
                      bannerText: '2h 45m remaining',
                      pillColor: const Color(0xFFFDE68A), // amber-200
                      pillText: 'HIGH / उच्च',
                      imageUrl: 'overflowing_dumpster_1791533637321.jpg',
                      ticketId: '#SW-392',
                      hazardIcon: Icons.delete_outline,
                      hazardIconColor: const Color(0xFFD97706), // amber-600
                      title: 'Overflowing Bin',
                      location: '12th Main Road, Near Metro...',
                      distance: '1.2 km away',
                      distanceColor: const Color(0xFF047857),
                      status: 'Dispatch Ready',
                    ),
                    const SizedBox(height: 16),
                    _buildTaskCard(
                      context,
                      bannerColor: const Color(0xFFA7F3D0), // emerald-200
                      bannerTextColor: const Color(0xFF065F46), // emerald-800
                      bannerIconColor: const Color(0xFF047857), // emerald-700
                      bannerText: '5h 20m remaining',
                      pillColor: const Color(0xFFE0E7FF), // indigo-100
                      pillText: 'MEDIUM',
                      imageUrl: 'drain_silt_hazard_1791533703667.jpg', // using drain image
                      ticketId: '#DR-441',
                      hazardIcon: Icons.home_outlined,
                      hazardIconColor: const Color(0xFF047857), // emerald-700
                      title: 'Drain Blocked',
                      location: '7th B Main, Indiranagar Club...',
                      distance: '2.1 km away',
                      distanceColor: const Color(0xFF047857),
                      status: 'Queued',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 6. Shift Schedule Box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF), // indigo-50
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
                            Icon(Icons.restaurant_outlined, size: 18, color: Color(0xFF0F172A)),
                            SizedBox(width: 8),
                            Text(
                              'Shift Schedule',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDE68A), // amber-200
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Lunch at 13:00',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF92400E), // amber-800
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '3 tasks due before lunch break. Keep dispatch updated on mobile radio.',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: CivicColors.textPrimaryLight,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Squad Helpline',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: CivicColors.textSecondaryLight,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE4E6), // pink-100
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.call_outlined, size: 14, color: Color(0xFFE11D48)), // rose-600
                              SizedBox(width: 6),
                              Text(
                                'Call 1913 (Urgent Dispatch)',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFE11D48),
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

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPill(String text, {required bool isSelected, required String? countIndicator, Color? countColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? CivicColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? CivicColors.primary : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : CivicColors.textPrimaryLight,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
          if (countIndicator != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: countColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                countIndicator,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B), // slate-800
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required Color bannerColor,
    required String bannerText,
    required Color pillColor,
    required String pillText,
    required String imageUrl,
    required String ticketId,
    required IconData hazardIcon,
    required Color hazardIconColor,
    required String title,
    required String location,
    required String distance,
    required Color distanceColor,
    required String status,
    Color bannerTextColor = Colors.white,
    Color bannerIconColor = Colors.white,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)), // slate-100
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
          // Banner Row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: bannerColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 12, color: bannerIconColor),
                      const SizedBox(width: 6),
                      Text(
                        bannerText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: bannerTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: pillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    pillText,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(color: Colors.grey.shade300),
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              ticketId,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
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
                        children: [
                          Icon(hazardIcon, size: 18, color: hazardIconColor),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: CivicColors.textPrimaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: CivicColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.near_me_outlined, size: 14, color: distanceColor),
                          const SizedBox(width: 4),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: distanceColor,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: CivicColors.textSecondaryLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: CivicColors.textPrimaryLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CivicColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.play_circle_outline, size: 16),
                      label: const Text(
                        'Start Task / कार्य शुरू करें',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TaskResolutionScreen()),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  width: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF), // indigo-50
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.directions_outlined, color: CivicColors.primaryDark, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
