import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryTeal = Color(0xFF006B5F);
  static const Color primaryGreen = primaryTeal;
  static const Color warning = Color(0xFFF9A825);
  static const Color primaryLight = Color(0xFFE6F3F1);
  static const Color background = Color(0xFFF7F9FA);
  static const Color textDark = Color(0xFF1A1D1E);
  static const Color textLight = Color(0xFF6B7280);
  static const Color cardBg = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryTeal,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: primaryTeal,
        secondary: primaryTeal,
        background: background,
        surface: cardBg,
      ),
      fontFamily: 'Roboto', // Defaulting to Roboto
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
