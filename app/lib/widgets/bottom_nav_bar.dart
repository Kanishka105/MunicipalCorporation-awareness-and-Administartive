import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../screens/report_hazard_modal.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentIndex = state.currentNavIndex;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1. Feed
              _buildNavItem(
                index: 0,
                icon: Icons.article_outlined,
                activeIcon: Icons.article_rounded,
                label: state.tr('feedTab'),
                isSelected: currentIndex == 0,
                isDark: isDark,
                onTap: () => state.setNavIndex(0),
              ),

              // 2. Tasks
              _buildNavItem(
                index: 1,
                icon: Icons.checklist_rtl_outlined,
                activeIcon: Icons.checklist_rtl_rounded,
                label: state.tr('tasksTab'),
                isSelected: currentIndex == 1,
                isDark: isDark,
                onTap: () => state.setNavIndex(1),
              ),

              // 3. Center Camera Action Button
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => const ReportHazardModal(),
                  );
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: CivicColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CivicColors.primary.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),

              // 4. Copilot
              _buildNavItem(
                index: 2,
                icon: Icons.smart_toy_outlined,
                activeIcon: Icons.smart_toy_rounded,
                label: state.tr('copilotTab'),
                isSelected: currentIndex == 2,
                isDark: isDark,
                onTap: () => state.setNavIndex(2),
              ),

              // 5. Executive Dashboard
              _buildNavItem(
                index: 4,
                icon: Icons.admin_panel_settings_outlined,
                activeIcon: Icons.admin_panel_settings_rounded,
                label: state.tr('dashboardTab'),
                isSelected: currentIndex == 4,
                isDark: isDark,
                onTap: () => state.setNavIndex(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final activeColor = CivicColors.primary;
    final inactiveColor = isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
