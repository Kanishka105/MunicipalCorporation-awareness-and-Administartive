import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false; // toggle for Log In / Sign Up
  bool autoTaggingEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Status Bar mock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'GPS: ACTIVE [±3m]',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.satellite_alt, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'READY',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              // Logo
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.location_on, size: 40, color: AppTheme.primaryColor),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: AppTheme.primaryColor,
                        child: Icon(Icons.camera_alt, size: 12, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'CleanCity',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Photo-first social discovery tagged with real-\nworld coordinates.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),
              
              // Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isLogin ? AppTheme.primaryColor : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: !isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !isLogin ? AppTheme.primaryColor : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Form
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isLogin) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('PUBLIC TAG', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(icon: Icons.person_outline, hint: 'Maya Lin'),
                      const SizedBox(height: 16),
                    ],
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email Address', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('VERIFIED', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(icon: Icons.email_outlined, hint: 'photographer@cleancity.io'),
                    const SizedBox(height: 16),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    _buildTextField(icon: Icons.lock_outline, hint: '••••••••••••', isPassword: true),
                    const SizedBox(height: 16),
                    
                    if (!isLogin) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.my_location, color: AppTheme.primaryColor),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Auto-tagging Enabled', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                  Text('Captures will attach verified coordinates', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                                ],
                              ),
                            ),
                            Switch(
                              value: autoTaggingEnabled,
                              onChanged: (val) => setState(() => autoTaggingEnabled = val),
                              activeColor: AppTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Continue to CleanCity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Stats Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF7FFFD4), // light mint
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.explore, color: AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('12,480+ Expeditions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Tagged by local creators worldwide', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _buildSmallStatIcon(Icons.terrain),
                        const SizedBox(width: -8),
                        _buildSmallStatIcon(Icons.water_drop),
                        const SizedBox(width: -8),
                        _buildSmallStatIcon(Icons.forest),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'By continuing, you agree to enable camera and GPS\nlocation permissions when posting.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallStatIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, size: 12, color: AppTheme.primaryColor),
    );
  }

  Widget _buildTextField({required IconData icon, required String hint, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppTheme.textSecondary),
          suffixIcon: isPassword ? Icon(Icons.visibility_outlined, color: AppTheme.textSecondary) : null,
          hintText: hint,
          hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
