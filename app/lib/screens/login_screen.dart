import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/civic_app_state.dart';
import '../models/user_model.dart';
import '../theme/app_theme.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  void _submitLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      final state = context.read<CivicAppState>();
      await state.loginAs(
        role: UserRole.citizen,
        name: 'Priya Sharma',
        phone: '+91 9845012384',
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigationShell()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CivicAppState>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? CivicColors.bgDark : const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Top Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFE5E7EB),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.account_balance_outlined, size: 16, color: CivicColors.primary),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BBMP CIVIC CONNECT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                              ),
                            ),
                            Text(
                              'Govt. of Karnataka',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Language Switcher (EN / HI)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: CivicColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'EN',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: const Text(
                              'हि',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: CivicColors.textSecondaryLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFEEF2FF), // indigo-50
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.security_outlined, size: 16, color: CivicColors.primaryDark), // emerald-900
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Ministry of Housing & Urban Affairs • BBMP Smart Civic Initiative',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 3. Logo & Title
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: CivicColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.local_florist_rounded, color: Colors.white, size: 36),
                    ),
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF59E0B), // amber-500
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 8, color: Colors.white), // arbitrary icon for orange badge
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'CleanCity',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Report. Track. Clean.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: CivicColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'रिपोर्ट करें • ट्रैक करें • स्वच्छ बनाएं',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: CivicColors.textSecondaryLight,
                ),
              ),

              const SizedBox(height: 32),

              // 4. Login Box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? CivicColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Citizen Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5), // emerald-100
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'OTP Verified',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF065F46), // emerald-800
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'नागरिक प्रवेश • Fast, passwordless entry',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: CivicColors.textPrimaryLight,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Phone Input
                    const Text(
                      'Registered Mobile Number *',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC), // slate-50
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)), // slate-200
                      ),
                      child: Row(
                        children: [
                          const Text('🇮🇳 +91', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              '9845012384',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1),
                            ),
                          ),
                          const Icon(Icons.edit_outlined, size: 18, color: CivicColors.textSecondaryLight),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Linkage detected
                    Row(
                      children: const [
                        Icon(Icons.check_circle_outline, size: 14, color: CivicColors.primary),
                        SizedBox(width: 6),
                        Text(
                          'Aadhaar/Ward linkage auto-detected',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: CivicColors.textPrimaryLight,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'SMS sent to +91 98450 •••84',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CivicColors.textSecondaryLight),
                        ),
                        Text(
                          'Change',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: CivicColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // OTP Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFEEF2FF)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Enter 6-Digit Civic PIN / OTP',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.timer_outlined, size: 12, color: CivicColors.primary),
                                  SizedBox(width: 4),
                                  Text(
                                    '24s remaining',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: CivicColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildOtpBox('5'),
                              _buildOtpBox('8'),
                              _buildOtpBox('2'),
                              _buildOtpBox('•'),
                              _buildOtpBox('•'),
                              _buildOtpBox('•'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Didn\'t receive code?',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CivicColors.textSecondaryLight),
                              ),
                              Text(
                                'Resend OTP in 24s',
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CivicColors.textSecondaryLight),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CivicColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: _isLoading ? null : _submitLogin,
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Verify & Continue / सत्यापन करें',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_forward, size: 16),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFD1FAE5), // emerald-100
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.security_outlined, size: 14, color: CivicColors.primary),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Fast login without password. Verified with Aadhaar & Mobile linked civic voter registration records.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: CivicColors.textPrimaryLight,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              
              // Bottom Helpline Pill
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF), // indigo-50
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE4E6), // pink-100
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.call_outlined, size: 16, color: Color(0xFFE11D48)), // rose-600
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Toll-free 1913 Swachhatha Sahayata',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                        ),
                        Text(
                          '24x7 Municipal Emergency Desk',
                          style: TextStyle(fontSize: 9, color: CivicColors.textSecondaryLight),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, size: 12, color: CivicColors.textSecondaryLight),
                  SizedBox(width: 4),
                  Text('256-bit Encrypted', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CivicColors.textSecondaryLight)),
                  SizedBox(width: 8),
                  Text('•', style: TextStyle(fontSize: 10, color: CivicColors.textSecondaryLight)),
                  SizedBox(width: 8),
                  Text('BBMP East • Ward 142', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CivicColors.textSecondaryLight)),
                  SizedBox(width: 8),
                  Text('•', style: TextStyle(fontSize: 10, color: CivicColors.textSecondaryLight)),
                  SizedBox(width: 8),
                  Text('Privacy', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: CivicColors.textSecondaryLight)),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(String digit) {
    return Container(
      width: 40,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Text(
          digit,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: digit == '•' ? const Color(0xFF94A3B8) : const Color(0xFF047857), // emerald-700
          ),
        ),
      ),
    );
  }
}
