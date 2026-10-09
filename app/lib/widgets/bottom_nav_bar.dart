import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Home
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'गृह', // Home
                isSelected: currentIndex == 0,
                isDark: isDark,
                onTap: () => state.setNavIndex(0),
              ),

              // 2. My Reports
              _buildNavItem(
                index: 1,
                icon: Icons.assignment_outlined,
                activeIcon: Icons.assignment,
                label: 'मेरी शिकायतें', // My Reports
                isSelected: currentIndex == 1,
                isDark: isDark,
                onTap: () => state.setNavIndex(1),
              ),

              // 3. Rewards
              _buildNavItem(
                index: 2,
                icon: Icons.emoji_events_outlined,
                activeIcon: Icons.emoji_events,
                label: 'रिवॉर्ड्स', // Rewards
                isSelected: currentIndex == 2,
                isDark: isDark,
                onTap: () => state.setNavIndex(2),
              ),

              // 4. Profile
              _buildNavItem(
                index: 3,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'प्रोफाइल', // Profile
                isSelected: currentIndex == 3,
                isDark: isDark,
                onTap: () => state.setNavIndex(3),
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
    final activeColor = CivicColors.primaryDark; // Use dark green for active tab
    final inactiveColor = const Color(0xFF64748B); // slate-500

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? activeColor : inactiveColor,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
