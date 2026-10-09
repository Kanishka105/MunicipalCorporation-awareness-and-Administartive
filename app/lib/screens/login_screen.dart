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
  UserRole _selectedRole = UserRole.citizen;
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _nameController = TextEditingController(text: 'Aarav Sharma');
  final _wardController = TextEditingController(text: 'DTU Ward 42');
  final _unitController = TextEditingController(text: 'Unit #3');
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _wardController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _onRoleChanged(UserRole role) {
    setState(() {
      _selectedRole = role;
      if (role == UserRole.citizen) {
        _nameController.text = 'Aarav Sharma';
        _phoneController.text = '+91 98765 43210';
      } else if (role == UserRole.fieldOfficer) {
        _nameController.text = 'Rajesh Kumar';
        _phoneController.text = '+91 94123 78901';
      } else {
        _nameController.text = 'Sunita Verma';
        _phoneController.text = '+91 98111 22334';
      }
    });
  }

  void _submitLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      final state = context.read<CivicAppState>();
      await state.loginAs(
        role: _selectedRole,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        unitId: _selectedRole == UserRole.fieldOfficer ? _unitController.text.trim() : null,
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row with Theme Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: CivicColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(Icons.hub_outlined, color: Colors.white, size: 22),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'CivicPulse',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? CivicColors.mint.withOpacity(0.2) : CivicColors.mintBadgeBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'AI',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: CivicColors.mintDark),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                          color: isDark ? Colors.amber : CivicColors.textSecondaryLight,
                        ),
                        onPressed: () => state.toggleTheme(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Welcome Header
                  Text(
                    'Municipal Corporation of Delhi',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: CivicColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'CivicPulse Portal Access',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : CivicColors.textPrimaryLight,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'AI-powered citizen triage, geofenced proof audit & real-time telemetry dispatch.',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? CivicColors.textSecondaryDark : CivicColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Role Switcher Tabs
                  Text(
                    'Select Your Operating Role',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : CivicColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildRoleButton(
                        role: UserRole.citizen,
                        label: 'Citizen',
                        icon: Icons.person_outline,
                        isDark: isDark,
                      ),
                      const SizedBox(width: 8),
                      _buildRoleButton(
                        role: UserRole.fieldOfficer,
                        label: 'Field Officer',
                        icon: Icons.engineering_outlined,
                        isDark: isDark,
                      ),
                      const SizedBox(width: 8),
                      _buildRoleButton(
                        role: UserRole.zonalSupervisor,
                        label: 'Supervisor',
                        icon: Icons.verified_user_outlined,
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name field
                  _buildTextField(
                    label: 'Full Name',
                    controller: _nameController,
                    icon: Icons.badge_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),

                  // Phone / ID
                  _buildTextField(
                    label: _selectedRole == UserRole.citizen ? 'Mobile Phone (+91)' : 'Officer ID / Mobile',
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),

                  // Unit ID for Officer
                  if (_selectedRole == UserRole.fieldOfficer) ...[
                    _buildTextField(
                      label: 'Assigned Unit Tag',
                      controller: _unitController,
                      icon: Icons.fire_truck_outlined,
                      isDark: isDark,
                    ),
                    const SizedBox(height: 14),
                  ],

                  // Ward selection
                  _buildTextField(
                    label: 'Municipal Jurisdiction',
                    controller: _wardController,
                    icon: Icons.location_city_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 24),

                  // Submit Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CivicColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                      onPressed: _isLoading ? null : _submitLogin,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Enter CivicPulse as ${_selectedRole == UserRole.citizen ? 'Citizen' : _selectedRole == UserRole.fieldOfficer ? 'Field Officer' : 'Supervisor'}',
                              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quick Demo One-Tap Buttons
                  Center(
                    child: Text(
                      'Or quick launch with verified profiles:',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? CivicColors.textMutedDark : CivicColors.textMutedLight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            _onRoleChanged(UserRole.citizen);
                            _submitLogin();
                          },
                          child: const Text('Aarav (Citizen)', style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            _onRoleChanged(UserRole.fieldOfficer);
                            _submitLogin();
                          },
                          child: const Text('Rajesh (Unit #3)', style: TextStyle(fontSize: 11)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required UserRole role,
    required String label,
    required IconData icon,
    required bool isDark,
  }) {
    final isSelected = _selectedRole == role;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onRoleChanged(role),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? CivicColors.primary
                : (isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF1F5F9)),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? CivicColors.primary
                  : (isDark ? CivicColors.borderDark : CivicColors.borderLight),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : CivicColors.textPrimaryLight),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : CivicColors.textPrimaryLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : CivicColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 13.5,
            color: isDark ? Colors.white : CivicColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: CivicColors.primary),
            filled: true,
            fillColor: isDark ? CivicColors.cardSurfaceDark : const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? CivicColors.borderDark : CivicColors.borderLight),
            ),
          ),
        ),
      ],
    );
  }
}
