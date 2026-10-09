import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
                                  '| Rewards',
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

              // 2. Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Civic Rewards & Trust', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                        SizedBox(height: 2),
                        Text('नागरिक सम्मान एवं विश्वास सूचकांक', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF), // indigo-50
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.verified_outlined, color: CivicColors.primaryDark, size: 12),
                          SizedBox(width: 4),
                          Text('Ward 142', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CivicColors.primaryDark)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 3. Karma Balance Card
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
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(Icons.star, size: 120, color: Colors.white.withOpacity(0.1)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.emoji_events_outlined, color: Colors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text('SWACHH KARMA BALANCE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                            const Text(
                              'Active Tier: L4',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: const [
                            Text(
                              '2,450',
                              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: -1),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Karma Pts',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Equivalent to ₹245 utility discount or municipal tax rebate voucher.',
                          style: TextStyle(color: Colors.white, fontSize: 11, height: 1.4),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: CivicColors.primaryDark,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.card_giftcard_outlined, size: 18),
                            label: const Text(
                              'Redeem Points / रिडीम करें',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 4. Credibility Index
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CREDIBILITY INDEX', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF475569))),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Reporter Trust Score:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7F3D0), // emerald-200
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Level 4 Civic Guardian', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF065F46))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('98%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Circular Chart
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: 0.98,
                                strokeWidth: 8,
                                backgroundColor: const Color(0xFFE2E8F0),
                                valueColor: const AlwaysStoppedAnimation<Color>(CivicColors.primaryDark),
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('98', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                                    Text('/ 100', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.check_circle_outline, color: CivicColors.primaryDark, size: 16),
                                  SizedBox(width: 4),
                                  Text('32 AI-Verified Validations', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '0 spam incidents or false flags logged. High accuracy ward contributor.',
                                style: TextStyle(fontSize: 11, color: Color(0xFF475569), height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF), // indigo-50
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.bolt, color: CivicColors.primaryDark, size: 18),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: 'Civic Fast-Track Active: ', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0F172A), fontSize: 11)),
                                  TextSpan(text: 'Your reports automatically skip manual tier triage and auto-dispatch to BBMP ward crews immediately.', style: TextStyle(color: Color(0xFF475569), fontSize: 11, height: 1.4)),
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

              const SizedBox(height: 32),

              // 5. Earned Badges
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Earned Badges / अर्जित पदक', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    Text('4 / 6 Unlocked', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primaryDark)),
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
                          child: _buildBadgeCard(
                            icon: Icons.emoji_events_outlined,
                            iconColor: const Color(0xFF92400E),
                            iconBg: const Color(0xFFFDE68A), // amber
                            badgeText: 'Gold',
                            badgeColor: const Color(0xFFD1FAE5),
                            badgeTextColor: const Color(0xFF065F46),
                            title: 'Spotless Pioneer',
                            desc: 'First 10 sanitation reports cleared within SLA.',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildBadgeCard(
                            icon: Icons.shield_outlined,
                            iconColor: const Color(0xFF0369A1),
                            iconBg: const Color(0xFFE0F2FE), // light blue
                            badgeText: 'Hazard',
                            badgeColor: const Color(0xFFEEF2FF),
                            badgeTextColor: const Color(0xFF312E81),
                            title: 'Night Watchman',
                            desc: 'Logged 5 critical streetlamp & pothole hazards.',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBadgeCard(
                            icon: Icons.eco_outlined,
                            iconColor: const Color(0xFF047857),
                            iconBg: const Color(0xFFA7F3D0), // emerald
                            badgeText: 'Ward 142',
                            badgeColor: const Color(0xFFA7F3D0),
                            badgeTextColor: const Color(0xFF065F46),
                            title: 'Zero Litter Champion',
                            desc: 'Facilitated block black-spot remediation.',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildBadgeCard(
                            icon: Icons.speed_outlined,
                            iconColor: const Color(0xFFB45309),
                            iconBg: const Color(0xFFFEF3C7), // amber
                            badgeText: 'Speed',
                            badgeColor: const Color(0xFFE2E8F0),
                            badgeTextColor: const Color(0xFF334155),
                            title: 'Fast Responder',
                            desc: 'Verified civic fixes in under 15 minutes.',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 6. Ward Society Leaderboard
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Ward 142 Society Leaderboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('वार्ड 142 सोसायटी लीडरबोर्ड • This Month', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.leaderboard_outlined, size: 14, color: CivicColors.primaryDark),
                        SizedBox(width: 4),
                        Text('Top 5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: CivicColors.primaryDark)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildLeaderboardItem(1, 'Indiranagar 2nd Stage RWA', '420 Active Residents', '14,820', isStar: true),
                    _buildLeaderboardItem(2, 'Def Col Residents Assoc', '310 Active Residents', '12,400'),
                    _buildLeaderboardItem(3, 'Priya Sharma (You)', '32 Verified Ward Actions', '2,450', isUser: true),
                    _buildLeaderboardItem(4, 'Metro Greens Society', '88 Active Residents', '2,190'),
                    _buildLeaderboardItem(5, 'BDA Complex Residents', '64 Active Residents', '1,850'),
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

  Widget _buildBadgeCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, size: 16, color: iconColor),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(10)),
                child: Text(badgeText, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: badgeTextColor)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 10, color: Color(0xFF475569), height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, String subtitle, String points, {bool isUser = false, bool isStar = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUser ? const Color(0xFFA7F3D0) : Colors.white, // emerald-200 for user
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isUser ? const Color(0xFF047857) : const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: rank == 1 ? const Color(0xFFFDE68A) : (isUser ? const Color(0xFF065F46) : const Color(0xFFEEF2FF)),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: rank == 1 ? const Color(0xFF92400E) : (isUser ? Colors.white : const Color(0xFF1E293B)),
                ),
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
                    Text(name, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: isUser ? const Color(0xFF064E3B) : const Color(0xFF0F172A))),
                    if (isStar) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.star_border, size: 14, color: Color(0xFFD97706)),
                    ],
                    if (isUser) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFF065F46), borderRadius: BorderRadius.circular(4)),
                        child: const Text('Citizen', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 10, color: isUser ? const Color(0xFF065F46) : const Color(0xFF64748B))),
              ],
            ),
          ),
          Text(
            '$points\npts',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: (rank == 1 || isUser) ? const Color(0xFF047857) : const Color(0xFF475569)),
          ),
        ],
      ),
    );
  }
}
