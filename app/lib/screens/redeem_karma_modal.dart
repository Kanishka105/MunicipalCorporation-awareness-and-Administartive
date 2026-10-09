import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

class RedeemKarmaModal extends StatelessWidget {
  const RedeemKarmaModal({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = state.currentUser;
    final currentPoints = user?.karmaPoints ?? 340;

    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
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
                      color: CivicColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.confirmation_number_outlined, color: CivicColors.primary, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Redeem Karma Points',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                        ),
                      ),
                      Text(
                        'Available Balance: $currentPoints KP',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: CivicColors.primary,
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
          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              children: [
                _buildPassOption(
                  context: context,
                  state: state,
                  title: 'DTC AC/Non-AC Bus Daily Pass',
                  pointsCost: 100,
                  availablePoints: currentPoints,
                  isDark: isDark,
                  icon: Icons.directions_bus_filled,
                ),
                const SizedBox(height: 12),
                _buildPassOption(
                  context: context,
                  state: state,
                  title: 'Delhi Metro Yellow Line ₹50 QR Ticket',
                  pointsCost: 200,
                  availablePoints: currentPoints,
                  isDark: isDark,
                  icon: Icons.subway_rounded,
                ),
                const SizedBox(height: 12),
                _buildPassOption(
                  context: context,
                  state: state,
                  title: 'DMRC Weekly Unlimited Pass Voucher',
                  pointsCost: 500,
                  availablePoints: currentPoints,
                  isDark: isDark,
                  icon: Icons.card_membership_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassOption({
    required BuildContext context,
    required CivicAppState state,
    required String title,
    required int pointsCost,
    required int availablePoints,
    required bool isDark,
    required IconData icon,
  }) {
    final canAfford = availablePoints >= pointsCost;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardSurfaceDark : CivicColors.bgLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? CivicColors.borderDark : CivicColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CivicColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: CivicColors.primary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$pointsCost KP required',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: canAfford ? CivicColors.mintDark : CivicColors.urgentRed,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: canAfford ? CivicColors.primary : Colors.grey.shade400,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: canAfford
                ? () {
                    final success = state.redeemKarmaPoints(pointsCost);
                    if (success) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: CivicColors.mintDark,
                          content: Text('🎉 Pass redeemed successfully! -$pointsCost KP deducted.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                : null,
            child: Text(canAfford ? 'Redeem' : 'Locked'),
          ),
        ],
      ),
    );
  }
}
