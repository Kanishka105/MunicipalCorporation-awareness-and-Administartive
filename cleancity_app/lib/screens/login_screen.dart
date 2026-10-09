import 'package:flutter/material.dart';
import '../theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Status Bar
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primaryTeal, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        const Text('GPS: ACTIVE [±3m]', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.satellite_alt, size: 12, color: AppTheme.textLight),
                        SizedBox(width: 6),
                        Text('READY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              
              // Logo
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: AppTheme.primaryTeal.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: const Icon(Icons.location_on, color: Colors.white, size: 36),
                  ),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryTeal,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: AppTheme.primaryTeal, size: 12),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              
              const Text('CleanCity', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.textDark)),
              const SizedBox(height: 8),
              const Text(
                'Photo-first social discovery tagged with real-\nworld coordinates.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppTheme.textLight, height: 1.4),
              ),
              const SizedBox(height: 32),
              
              // Toggle Log In / Sign Up
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: isLogin ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
                          ),
                          child: Center(
                            child: Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, color: isLogin ? AppTheme.primaryTeal : AppTheme.textLight)),
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
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: !isLogin ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
                          ),
                          child: Center(
                            child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: !isLogin ? AppTheme.primaryTeal : AppTheme.textLight)),
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isLogin) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Full Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                          Text('PUBLIC TAG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Maya Lin',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: const Icon(Icons.person_outline, color: AppTheme.textLight, size: 20),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Email Address', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                        Text('VERIFIED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'photographer@cleancity.io',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: const Icon(Icons.mail_outline, color: AppTheme.textLight, size: 20),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    const Text('Password', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: AppTheme.background, borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.textLight, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppTheme.textLight, size: 20),
                            onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.gps_fixed, color: AppTheme.primaryTeal, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Auto-tagging Enabled', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                                Text('Captures will attach verified coordinates', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 54),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Continue to CleanCity'),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Footer Stats
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.tealAccent, shape: BoxShape.circle),
                      child: const Icon(Icons.explore, color: AppTheme.primaryTeal, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('12,480+ Expeditions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                          Text('Tagged by local creators worldwide', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        _buildSmallIcon(Icons.landscape),
                        _buildSmallIcon(Icons.water_drop),
                        _buildSmallIcon(Icons.park),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              const Text(
                'By continuing, you agree to enable camera and GPS\nlocation permissions when posting.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: AppTheme.textLight),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 10, color: AppTheme.primaryTeal),
    );
  }
}
