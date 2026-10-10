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
  bool isLogin = false; // toggle for Log In / Sign Up
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
                      Icon(Icons.lock_clock, size: 14, color: AppTheme.primaryColor),
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
                'Citizen Engagement & Field Geotagging Platform',
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
                    _buildTextField(icon: Icons.phone_android, hint: '+91 9876543210', controller: mobileController, keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(height: 8),
                    _buildTextField(icon: Icons.lock_outline, hint: '••••••••••••', isPassword: true, controller: passwordController),
                    if (!isLogin) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Must be 8+ chars (e.g. Clean@123)',
                        style: TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                      ),
                    ],
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
                        onPressed: isLoading
                            ? null
                            : () async {
                                final mobile = mobileController.text.trim();
                                final password = passwordController.text;
                                final name = nameController.text.trim();
                                
                                if (mobile.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please enter your 10-digit mobile number')),
                                  );
                                  return;
                                }

                                if (password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please enter your password')),
                                  );
                                  return;
                                }

                                if (!isLogin && name.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                    // Show OTP Dialog
                                    final otpController = TextEditingController();
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (dialogCtx) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        title: const Text('Verify Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Enter the 6-digit verification OTP sent to $mobile:',
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
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Please enter the OTP')),
                                                );
                                                return;
                                              }
                                              final verifyRes = await _apiService.verifyOtp(mobile, otp);
                                              if (verifyRes['success'] == true) {
                                                Navigator.of(dialogCtx).pop();
                                                if (mounted) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Icon(Icons.check_circle, color: Colors.white),
                                                          SizedBox(width: 8),
                                                          Text('Account verified with AWS Cognito!'),
                                                        ],
                                                      ),
                                                      backgroundColor: Color(0xFF16A34A),
                                                      duration: Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                                // Auto login after verification
                                                final loginRes = await _apiService.login(mobile, password);
                                                if (loginRes['success'] == true && mounted) {
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                                  );
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(verifyRes['message'] ?? 'Invalid OTP. Please try again.')),
                                                );
                                              }
                                            },
                                            child: const Text('Verify & Complete'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(result['message'] ?? 'Sign up failed')),
                                    );
                                  }
                                } else {
                                  // Login Flow
                                  final loginRes = await _apiService.login(mobile, password);
                                  if (!mounted) return;
                                  setState(() => isLoading = false);
                                  
                                  if (loginRes['success'] == true) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                  Text(isLogin ? 'Sign In to CleanCity' : 'Create Cognito Account', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward),
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
                        Align(widthFactor: 0.7, child: _buildSmallStatIcon(Icons.terrain)),
                        Align(widthFactor: 0.7, child: _buildSmallStatIcon(Icons.water_drop)),
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

  Widget _buildTextField({required IconData icon, required String hint, bool isPassword = false, TextEditingController? controller, TextInputType? keyboardType}) {
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
          hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
