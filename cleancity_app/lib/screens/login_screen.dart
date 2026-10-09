import 'package:flutter/material.dart';
import '../theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance, color: AppTheme.primaryGreen),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('BBMP CIVIC CONNECT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textLight)),
                          const Text('Govt. of Karnataka', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('EN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('हि', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),
              // Ministry Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF2F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: AppTheme.primaryGreen, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Ministry of Housing & Urban Affairs • BBMP Smart Civic Initiative',
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey[800], fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Logo
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.local_florist, color: Colors.white, size: 40),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chevron_left, color: Colors.white, size: 12),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('CleanCity', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 4),
              const Text('Report. Track. Clean.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
              const SizedBox(height: 4),
              const Text('रिपोर्ट करें • ट्रैक करें • स्वच्छ बनाएं', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
              const SizedBox(height: 32),
              
              // Login Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Citizen Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('OTP Verified', style: TextStyle(color: AppTheme.primaryGreen, fontSize: 12, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('नागरिक प्रवेश • Fast, passwordless entry', style: TextStyle(fontSize: 12, color: AppTheme.textLight, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 20),
                    
                    const Text.rich(
                      TextSpan(
                        text: 'Registered Mobile Number ',
                        style: TextStyle(fontSize: 12, color: AppTheme.textDark, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                        ],
                      )
                    ),
                    const SizedBox(height: 8),
                    
                    // Phone Number Input (Mocked)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          const Text('🇮🇳 +91', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text('9845012384', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                          ),
                          Icon(Icons.edit_outlined, color: Colors.grey[500], size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: AppTheme.primaryGreen, size: 14),
                        const SizedBox(width: 4),
                        const Text('Aadhaar/Ward linkage auto-detected', style: TextStyle(fontSize: 12, color: AppTheme.textDark, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('SMS sent to +91 98450 •••84', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                        Text('Change', style: TextStyle(fontSize: 12, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // OTP Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6FB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Enter 6-Digit Civic PIN / OTP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Icon(Icons.timer_outlined, color: AppTheme.primaryGreen, size: 14),
                                  const SizedBox(width: 4),
                                  const Text('24s remaining', style: TextStyle(fontSize: 12, color: AppTheme.primaryGreen, fontWeight: FontWeight.w600)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          // OTP Digits
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildOtpBox('5', true),
                              _buildOtpBox('8', true),
                              _buildOtpBox('2', true),
                              _buildOtpBox('•', false),
                              _buildOtpBox('•', false),
                              _buildOtpBox('•', false),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Didn't receive code?", style: TextStyle(fontSize: 12, color: AppTheme.textLight, fontWeight: FontWeight.w600)),
                              const Text('Resend OTP in 24s', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Verify & Continue / सत्यापन करें', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, size: 18),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_outlined, color: AppTheme.primaryGreen, size: 20),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Fast login without password. Verified with Aadhaar & Mobile linked civic voter registration records.',
                            style: TextStyle(fontSize: 12, color: AppTheme.textLight, height: 1.5),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Support Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.red[50], shape: BoxShape.circle),
                      child: Icon(Icons.call, color: Colors.red[400], size: 16),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Toll-free 1913 Swachhatha Sahayata', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text('24×7 Municipal Emergency Desk', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, size: 12, color: AppTheme.textLight),
                  SizedBox(width: 4),
                  Text('256-bit Encrypted', style: TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold)),
                  Text('  •  ', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                  Text('BBMP East • Ward 142', style: TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold)),
                  Text('  •  ', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                  Text('Privacy', style: TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(String digit, bool filled) {
    return Container(
      width: 45,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: filled ? AppTheme.primaryGreen.withOpacity(0.3) : Colors.transparent),
        boxShadow: [
          if (filled)
            BoxShadow(color: AppTheme.primaryGreen.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))
        ]
      ),
      child: Text(
        digit,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: filled ? AppTheme.primaryGreen : Colors.grey[400],
        ),
      ),
    );
  }
}
