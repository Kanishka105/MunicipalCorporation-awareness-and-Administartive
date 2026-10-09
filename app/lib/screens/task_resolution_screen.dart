import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TaskResolutionScreen extends StatelessWidget {
  const TaskResolutionScreen({super.key});

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

              // 2. Task Header Pill
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.check_circle_outline, size: 14, color: CivicColors.primary),
                              SizedBox(width: 4),
                              Text(
                                'Task #SW-392',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Ward 142',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA7F3D0), // emerald-200
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'SLA: 42m Left',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 3. Geofence Confirmed
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5), // emerald-100
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.circle, color: Color(0xFF047857), size: 10), // emerald-700
                        SizedBox(width: 6),
                        Text(
                          'Geofence Confirmed (स्थान सत्यापित)',
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Within 12m of geotagged bin sensor (GPS Precision: ±2.4m).',
                      style: TextStyle(fontSize: 11, color: Color(0xFF065F46)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 4. Before Photo Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.history, size: 16, color: Color(0xFF92400E)), // amber-800
                        SizedBox(width: 6),
                        Text(
                          'Before Photo (नागरिक रिपोर्ट)',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '08:30 AM • Citizen',
                          style: TextStyle(fontSize: 10, color: Color(0xFF475569)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'overflowing_dumpster_1791533637321.jpg', // Before photo
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF334155).withOpacity(0.9), // slate-700
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.warning_amber_rounded, size: 12, color: Color(0xFFFDE68A)), // amber-200
                                    SizedBox(width: 6),
                                    Text(
                                      'Citizen Report • Indiranagar 12th Main',
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'monospace'),
                                    ),
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

              const SizedBox(height: 24),

              // 5. After Photo Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.camera_alt_outlined, size: 16, color: Color(0xFF047857)), // emerald-700
                            SizedBox(width: 6),
                            Text(
                              'After Photo (कार्य उपरांत\nफ़ोटो)',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), height: 1.2),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5), // emerald-100
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(color: Color(0xFF059669), shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Live Viewfinder',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF065F46)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?auto=format&fit=crop&w=600&q=80', // clean bin placeholder
                              fit: BoxFit.cover,
                            ),
                            // Viewfinder Corners
                            Positioned(
                              top: 16, left: 16,
                              child: _buildCornerBracket(top: true, left: true),
                            ),
                            Positioned(
                              top: 16, right: 16,
                              child: _buildCornerBracket(top: true, left: false),
                            ),
                            
                            // Center Box Overlay
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.filter_center_focus, size: 32, color: Colors.white),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    color: Colors.black54,
                                    child: const Text(
                                      'CENTER DUMPSTER BIN',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Bottom GPS overlay
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B).withOpacity(0.9), // slate-800
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'LAT: 12.9718° N, LON: 77.5946° E',
                                          style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          'TIMESTAMP: Today • 09:14:22 AM IST',
                                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 8, fontFamily: 'monospace'),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF047857), // emerald-700
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.check_circle_outline, color: Colors.white, size: 10),
                                          SizedBox(width: 4),
                                          Text(
                                            'GPS LOCKED',
                                            style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800),
                                          ),
                                        ],
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
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E7FF), // indigo-100
                          foregroundColor: const Color(0xFF1E1B4B), // indigo-950
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.camera_rounded, size: 18),
                        label: const Text(
                          'Take After Photo / फ़ोटो लें',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info_outline, size: 14, color: Color(0xFF92400E)), // amber-800
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Live photo required. Anti-spoofing & timestamp will be embedded automatically.',
                            style: TextStyle(fontSize: 10.5, color: Color(0xFF475569)), // slate-600
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 6. Sanitation Notes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Sanitation Notes (सफ़ाई विवरण)',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                        ),
                        Text(
                          'Optional',
                          style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Text(
                        'e.g. 120kg wet waste cleared, bin disinfected with lime powder, curb washed...',
                        style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildNotePill('+ Lime Powdered'),
                        _buildNotePill('+ Bulk Cleared'),
                        _buildNotePill('+ Unclogged Grate'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 7. Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF064E3B), // emerald-900
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                    label: const Text(
                      'Submit Proof & Verify / प्रमाण जमा करें',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 8. AI Inspection Simulator (Dev)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'AI INSPECTION\nSIMULATOR',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF475569)),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981), // emerald-500
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'State A\n(Success)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF), // indigo-100
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'State B\n(Alert)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF312E81), fontSize: 10, fontWeight: FontWeight.w800), // indigo-900
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5), // emerald-100
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.check_circle, color: Color(0xFF047857), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Verified by AI (एआई द्वारा सत्यापित)',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF065F46)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF047857),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '99% Clean',
                              style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Cleanliness score: 99.2%. Target sector verified spotless. Bin emptied & surrounding pavement scrubbed. Municipal SLA timer successfully stopped.',
                            style: TextStyle(fontSize: 11, color: Color(0xFF065F46), height: 1.4),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Ticket SW-392 marked:', style: TextStyle(fontSize: 9, color: Color(0xFF065F46))),
                                    Text('Resolved', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF047857))),
                                  ],
                                ),
                                const Text(
                                  'Closed at 09:15\nAM',
                                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF065F46), fontFamily: 'monospace'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildCornerBracket({required bool top, required bool left}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
          bottom: !top ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
          left: left ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
          right: !left ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNotePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF), // indigo-50
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF312E81)), // indigo-900
      ),
    );
  }
}
