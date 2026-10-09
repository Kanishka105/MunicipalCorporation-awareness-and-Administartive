import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart';

class TopHeader extends StatelessWidget implements PreferredSizeWidget {
  const TopHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = state.currentUser;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // CivicPulse Brand Logo
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: CivicColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: CivicColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.hub_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Title & AI pill & Ward info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'CivicPulse',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? CivicColors.mint.withOpacity(0.2) : CivicColors.mintBadgeBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: CivicColors.mint.withOpacity(0.4),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          'AI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isDark ? CivicColors.mint : CivicColors.mintDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
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
                      const SizedBox(width: 5),
                      Text(
                        user?.ward ?? 'DTU Ward 42',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Theme Toggle Button
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                color: isDark ? Colors.amber : CivicColors.textSecondaryLight,
                size: 22,
              ),
              tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              onPressed: () {
                state.toggleTheme();
              },
            ),

            // Notification Bell
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                    size: 24,
                  ),
                  onPressed: () {
                    _showNotificationSheet(context);
                  },
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: CivicColors.urgentRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 4),

            // User Profile Avatar
            GestureDetector(
              onTap: () {
                _showProfileModal(context, state);
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CivicColors.primary,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: user != null && user.role == UserRole.fieldOfficer
                      ? const Text(
                          'RK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 22,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? CivicColors.cardDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Ward Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                icon: Icons.check_circle_outline,
                iconColor: CivicColors.mint,
                title: 'Triage Pass: Gate 1 Debris',
                subtitle: 'Officer Sunita Verma signed off resolution proof.',
                time: '12:35 PM',
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              _buildNotificationItem(
                icon: Icons.warning_amber_rounded,
                iconColor: CivicColors.urgentRed,
                title: 'Urgent SLA Alert: Shahbad Drain',
                subtitle: 'Desilting assigned to Unit #3. SLA expiration: 28m.',
                time: '11:42 AM',
                isDark: isDark,
              ),
              const SizedBox(height: 10),
              _buildNotificationItem(
                icon: Icons.electric_bolt,
                iconColor: CivicColors.primary,
                title: '+10 Karma Points Earned',
                subtitle: 'You supported the DTU North Gate dumpster issue.',
                time: '10:15 AM',
                isDark: isDark,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
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

  void _showProfileModal(BuildContext context, CivicAppState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = state.currentUser;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? CivicColors.cardDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CivicColors.primary,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        user != null ? user.name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join() : 'CP',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Guest User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                          ),
                        ),
                        Text(
                          '${user?.role.name.toUpperCase()} • ${user?.ward}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: CivicColors.primary,
                          ),
                        ),
                        Text(
                          user?.phone ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                'Switch Operating Role',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: user?.role == UserRole.citizen ? CivicColors.primary.withOpacity(0.1) : null,
                        side: BorderSide(
                          color: user?.role == UserRole.citizen ? CivicColors.primary : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        state.loginAs(role: UserRole.citizen, name: 'Aarav Sharma', phone: '+91 98765 43210');
                        Navigator.pop(ctx);
                      },
                      child: const Text('Citizen'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: user?.role == UserRole.fieldOfficer ? CivicColors.primary.withOpacity(0.1) : null,
                        side: BorderSide(
                          color: user?.role == UserRole.fieldOfficer ? CivicColors.primary : Colors.grey.shade300,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        state.loginAs(role: UserRole.fieldOfficer, name: 'Rajesh Kumar', phone: '+91 94123 78901', unitId: 'Unit #3');
                        Navigator.pop(ctx);
                      },
                      child: const Text('Officer'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CivicColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text('Go to Authentication Page'),
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  icon: const Icon(Icons.logout, color: CivicColors.urgentRed),
                  label: const Text(
                    'Log Out Session',
                    style: TextStyle(color: CivicColors.urgentRed),
                  ),
                  onPressed: () {
                    state.logout();
                    Navigator.pop(ctx);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
