import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReportHazardModal extends StatelessWidget {
  const ReportHazardModal({super.key});

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
              // 1. Top Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, size: 20),
                        ),
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
                              'Report Grieva...',
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

              // 2. Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.gps_fixed, size: 14, color: CivicColors.primaryDark),
                        SizedBox(width: 4),
                        Text(
                          'Ward 142 • Indiranagar, BBMP East',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(color: Color(0xFF047857), shape: BoxShape.circle), // emerald-700
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'AI VISION READY',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF065F46)), // emerald-800
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // 3. Camera View
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 380,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'overflowing_dumpster_1791533637321.jpg',
                        fit: BoxFit.cover,
                      ),
                      // Top Left Overlay
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B).withOpacity(0.8), // slate-800
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(color: Color(0xFF6EE7B7), shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '12.9716° N, 77.5946° E • ±8m Precision',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Top Right Lightning
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B).withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.flash_off, color: Colors.white, size: 16),
                        ),
                      ),
                      // AI Box Center
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF047857), // emerald-700
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    'AI Match: 96% Overflowing',
                                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 180,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF6EE7B7), width: 3), // emerald-300
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Live Photo Mandate Banner
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.shield_outlined, color: Color(0xFFD97706), size: 16), // amber-600
                              SizedBox(width: 8),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Live photo mandate: ', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF92400E), fontSize: 10)),
                                      TextSpan(text: 'Municipal policy locks camera stream. File uploads disabled to prevent spoofing.', style: TextStyle(color: Color(0xFF0F172A), fontSize: 10, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 4. Action Buttons (Camera)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA7F3D0), // emerald-200
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.qr_code_scanner, color: Color(0xFF065F46), size: 16),
                            SizedBox(width: 8),
                            Text('Scan Bin QR\nक्यूआर स्कैन', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF065F46), fontSize: 10, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: CivicColors.primary, width: 4),
                      ),
                      child: Center(
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: CivicColors.primary, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt_outlined, color: CivicColors.primary, size: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF), // indigo-50
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.autorenew, color: Color(0xFF1E1B4B), size: 18),
                            SizedBox(width: 8),
                            Text('Retake\nफिर से लें', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1E1B4B), fontSize: 10, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 5. Select Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('SELECT CATEGORY / श्रेणी चुनें', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                        Text('AI Confirmed', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CivicColors.primaryDark)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: CivicColors.primaryDark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.delete_outline, color: Colors.white, size: 14),
                              SizedBox(width: 6),
                              Text('Overflowing Bin (कूड़ादान)', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF), // indigo-50
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.auto_awesome, color: Color(0xFF1E1B4B), size: 14),
                              SizedBox(width: 6),
                              Text('Garbage Dump (कचरा ढेर)', style: TextStyle(color: Color(0xFF1E1B4B), fontSize: 10, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 6. Landmark Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LANDMARK DETAILS / स्थल का विवरण', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add landmark details (e.g. Near Apollo Pharmacy, opposite park gate #2)...',
                            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Row(
                                children: [
                                  Icon(Icons.signpost_outlined, size: 12, color: Color(0xFF0F172A)),
                                  SizedBox(width: 4),
                                  Text('Helps sanitation marshals locate spot fast', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
                                ],
                              ),
                              Text('0/140', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF475569))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 7. Service Level Guarantee
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // slate-100
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA7F3D0), // emerald-200
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check_circle_outline, color: Color(0xFF065F46), size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Service Level Guarantee', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                          Text('SLA: 4-hour cleanup target', style: TextStyle(fontSize: 11, color: Color(0xFF475569))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0), // slate-200
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text('Zone 4', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 8. Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CivicColors.primaryDark,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.send_outlined, size: 16),
                    label: const Text(
                      'Submit Report / रिपोर्ट दर्ज करें',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Ward Inspector will acknowledge ticket within 15 minutes',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF334155)),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
