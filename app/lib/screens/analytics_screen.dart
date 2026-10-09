import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: CivicColors.heroCardGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: CivicColors.primary.withOpacity(0.3),
                  blurRadius: 12,
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
                    const Text(
                      'Ward 42 Telemetry & SLA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.shield, color: CivicColors.mint, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'Live Audit',
                            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _buildMetric('96.4%', 'SLA Compliance', Colors.white),
                    _buildMetric('38m', 'Avg Triage Time', Colors.white),
                    _buildMetric('148', 'Citizen Backers', Colors.white),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // GIS Hotspot Breakdown
          Text(
            'GIS Hazard Category Breakdown',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : CivicColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? CivicColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
              ),
            ),
            child: Column(
              children: [
                _buildCategoryRow('Solid Waste / Garbage Overflow', 0.45, '45%', CivicColors.urgentRed, isDark),
                const SizedBox(height: 12),
                _buildCategoryRow('Stormwater Drain Clogs', 0.32, '32%', CivicColors.primary, isDark),
                const SizedBox(height: 12),
                _buildCategoryRow('Potholes & Road Debris', 0.15, '15%', const Color(0xFFD97706), isDark),
                const SizedBox(height: 12),
                _buildCategoryRow('Streetlight / Electrical', 0.08, '8%', CivicColors.mintDark, isDark),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Field Squad Response Ratings
          Text(
            'Field Squad Units Performance',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : CivicColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 10),

          _buildSquadCard('Unit #3 (PWD Sanitation)', 'Rajesh Kumar • Driver DL-1GC', '98.2%', '⭐ 4.9', isDark),
          const SizedBox(height: 10),
          _buildSquadCard('Unit #12 (Civil Works)', 'Vikas Sharma • Suction Crew', '94.6%', '⭐ 4.8', isDark),
          const SizedBox(height: 10),
          _buildSquadCard('Unit #7 (Electrical)', 'Manoj Yadav • Tower Crane', '99.0%', '⭐ 5.0', isDark),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMetric(String val, String label, Color col) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            val,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: col),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String title, double factor, String pct, Color col, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
              ),
            ),
            Text(
              pct,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: col),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 6,
            color: isDark ? CivicColors.cardSurfaceDark : Colors.grey.shade200,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: factor,
                child: Container(color: col),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSquadCard(String unit, String driver, String rate, String rating, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CivicColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.fire_truck_outlined, color: CivicColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
                Text(
                  driver,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                rate,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: CivicColors.mintDark),
              ),
              Text(
                rating,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFD97706)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
