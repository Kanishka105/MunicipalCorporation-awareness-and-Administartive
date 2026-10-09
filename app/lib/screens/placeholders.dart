import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: Text(
          'My Reports Tab (मेरी शिकायतें)',
          style: TextStyle(fontSize: 18, color: CivicColors.textPrimaryLight),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: Text(
          'Profile Tab (प्रोफाइल)',
          style: TextStyle(fontSize: 18, color: CivicColors.textPrimaryLight),
        ),
      ),
    );
  }
}
