import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_screen.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true; // Default to Log In
  bool autoTaggingEnabled = true;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              // Status Bar
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
                        'AWS COGNITO AUTH',
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
                      const Icon(Icons.lock_clock, size: 14, color: AppTheme.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'SECURE',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 36),
              // Logo
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
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
                'Citizen Engagement & Field Geotagging Platform',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 28),
              
              // Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withValues(alpha: 0.3),
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
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Sign In',
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
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              'Create Account',
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
                      color: Colors.black.withValues(alpha: 0.02),
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
                          Text('CITIZEN PROFILE', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(icon: Icons.person_outline, hint: 'e.g. Gaurav Shukla', controller: nameController),
                      const SizedBox(height: 16),
                    ],
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text('COGNITO VERIFIED', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11, letterSpacing: 1)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(icon: Icons.phone_android, hint: 'e.g. 7307897622 or +91...', controller: mobileController, keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    _buildTextField(icon: Icons.lock_outline, hint: '••••••••••••', isPassword: true, controller: passwordController),
                    const SizedBox(height: 6),
                    Text(
                      isLogin
                          ? 'AWS Cognito User Pool authentication'
                          : 'Must be 8+ chars with uppercase, number & symbol (e.g. Clean@2026)',
                      style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                    ),
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
                              activeThumbColor: AppTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);
                                final navigator = Navigator.of(context);
                                final mobile = mobileController.text.trim();
                                final password = passwordController.text;
                                final name = nameController.text.trim();
                                
                                if (mobile.isEmpty) {
                                  messenger.showSnackBar(
                                    const SnackBar(content: Text('Please enter your mobile number')),
                                  );
                                  return;
                                }

                                if (password.isEmpty) {
                                  messenger.showSnackBar(
                                    const SnackBar(content: Text('Please enter your password')),
                                  );
                                  return;
                                }

                                if (!isLogin && name.isEmpty) {
                                  messenger.showSnackBar(
                                    const SnackBar(content: Text('Please enter your full name')),
                                  );
                                  return;
                                }
                                
                                setState(() => isLoading = true);
                                
                                if (!isLogin) {
                                  // Sign Up Flow
                                  final result = await _apiService.signUp(mobile, password, name.isNotEmpty ? name : "Citizen");
                                  if (!mounted) return;
                                  setState(() => isLoading = false);
                                  
                                  if (result['success'] == true) {
                                    _showOtpDialog(mobile, password, messenger, navigator);
                                  } else {
                                    messenger.showSnackBar(
                                      SnackBar(content: Text(result['message'] ?? 'Sign up failed')),
                                    );
                                  }
                                } else {
                                  // Login Flow
                                  final loginRes = await _apiService.login(mobile, password);
                                  if (!mounted) return;
                                  setState(() => isLoading = false);
                                  
                                  if (loginRes['success'] == true) {
                                    navigator.pushReplacement(
                                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                                    );
                                  } else {
                                    messenger.showSnackBar(
                                      SnackBar(content: Text(loginRes['message'] ?? 'Login failed. Check credentials.')),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isLogin ? 'Sign In to CleanCity' : 'Create Cognito Account',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Guest / Browse button
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        },
                        icon: const Icon(Icons.public, size: 16, color: AppTheme.primaryColor),
                        label: const Text(
                          'Browse Live Feed as Guest',
                          style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Live Telemetry Architecture Card (NO MOCK DATA)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentBlue.withValues(alpha: 0.3),
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
                      child: const Icon(Icons.cloud_done_outlined, color: AppTheme.primaryColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AWS Cloud Infrastructure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Live S3 data archiving & Cognito identity verification', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'By continuing, you enable camera and GPS\nlocation telemetry when publishing reports.',
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

  void _showOtpDialog(String mobile, String password, ScaffoldMessengerState messenger, NavigatorState navigator) {
    final otpController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        final dialogMessenger = ScaffoldMessenger.of(dialogCtx);
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Verify Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the 6-digit verification OTP for $mobile:',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter 6-digit OTP',
                  counterText: '',
                  prefixIcon: const Icon(Icons.security, size: 20, color: AppTheme.primaryColor),
                  filled: true,
                  fillColor: AppTheme.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final otp = otpController.text.trim();
                if (otp.isEmpty) {
                  dialogMessenger.showSnackBar(
                    const SnackBar(content: Text('Please enter the OTP')),
                  );
                  return;
                }
                final verifyRes = await _apiService.verifyOtp(mobile, otp);
                if (!dialogCtx.mounted) return;
                if (verifyRes['success'] == true) {
                  Navigator.of(dialogCtx).pop();
                  final loginRes = await _apiService.login(mobile, password);
                  if (loginRes['success'] == true && mounted) {
                    navigator.pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  }
                } else {
                  dialogMessenger.showSnackBar(
                    SnackBar(content: Text(verifyRes['message'] ?? 'Invalid OTP. Please try again.')),
                  );
                }
              },
              child: const Text('Verify & Complete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    bool isPassword = false,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppTheme.textSecondary),
          suffixIcon: isPassword ? Icon(Icons.visibility_outlined, color: AppTheme.textSecondary) : null,
          hintText: hint,
          hintStyle: TextStyle(color: AppTheme.textSecondary.withValues(alpha: 0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
