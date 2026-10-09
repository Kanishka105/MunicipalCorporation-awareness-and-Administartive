import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../theme/app_theme.dart';

class QrScannerModal extends StatefulWidget {
  const QrScannerModal({super.key});

  @override
  State<QrScannerModal> createState() => _QrScannerModalState();
}

class _QrScannerModalState extends State<QrScannerModal> {
  bool _isScanned = false;
  String _detectedNode = '#DTU-042';

  void _simulateScan(String node) async {
    setState(() {
      _detectedNode = node;
      _isScanned = true;
    });

    final state = context.read<CivicAppState>();
    state.backNodeFromQr(node);

    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CivicColors.mintDark,
          content: Text('⚡ Backed physical node $_detectedNode! +10 Karma Points added.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? CivicColors.cardDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan QR to Back Issue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                    ),
                  ),
                  Text(
                    'Physical Pole Nodes • No Duplicates',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // QR Viewfinder Box
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CivicColors.mint, width: 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isScanned)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, color: CivicColors.mint, size: 60),
                        const SizedBox(height: 12),
                        Text(
                          'Node Verified: $_detectedNode',
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '+10 Karma Points Awarded',
                          style: TextStyle(color: CivicColors.mintLight, fontSize: 13),
                        ),
                      ],
                    )
                  else
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(Icons.qr_code_scanner, color: CivicColors.mint, size: 80),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Align camera with physical pole node QR tag',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick simulated physical node buttons
          Text(
            'Or select detected nearby physical node:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CivicColors.mintBadgeBg,
                    foregroundColor: CivicColors.mintDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.qr_code_2, size: 18),
                  label: const Text('Node #DTU-042', style: TextStyle(fontWeight: FontWeight.w700)),
                  onPressed: () => _simulateScan('#DTU-042'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CivicColors.mintBadgeBg,
                    foregroundColor: CivicColors.mintDark,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.qr_code_2, size: 18),
                  label: const Text('Node #ROH-19', style: TextStyle(fontWeight: FontWeight.w700)),
                  onPressed: () => _simulateScan('#ROH-19'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
