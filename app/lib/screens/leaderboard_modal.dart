import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';
import '../models/leaderboard_model.dart';

class LeaderboardModal extends StatelessWidget {
  const LeaderboardModal({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.emoji_events_outlined, color: Colors.amber, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.tr('leaderboard'),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Ranked by Karma Points & Trust Reliability',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // User's own Trust Score banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: CivicColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified_user, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Your Citizen Trust Score',
                          style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '98.4% (Zero Fake Reports)',
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Rank #1',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Expanded(
            child: ListView.builder(
              itemCount: state.leaderboard.length,
              itemBuilder: (ctx, i) {
                final entry = state.leaderboard[i];
                return _buildLeaderboardCard(entry, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardCard(CitizenLeaderboardEntry entry, bool isDark) {
    Color rankColor = CivicColors.primary;
    if (entry.rank == 1) rankColor = Colors.amber.shade700;
    if (entry.rank == 2) rankColor = Colors.blueGrey;
    if (entry.rank == 3) rankColor = Colors.brown;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: entry.rank == 1
              ? Colors.amber.shade300
              : (isDark ? CivicColors.borderDark : CivicColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          // Rank circle
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: rankColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#${entry.rank}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: rankColor),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Avatar
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(entry.avatarUrl),
          ),
          const SizedBox(width: 10),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${entry.badge} • ${entry.verifiedReports} verified',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),

          // Karma & Trust
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.karmaPoints} KP',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: CivicColors.primary),
              ),
              Text(
                '${entry.trustScore}% Trust',
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: CivicColors.mintDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
