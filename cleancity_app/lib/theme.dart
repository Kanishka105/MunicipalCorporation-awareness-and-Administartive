import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF197A52);
  static const Color background = Color(0xFFF7F8FA);
  static const Color cardColor = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textLight = Color(0xFF6B7280);
  static const Color danger = Color(0xFFDC2626);
  static const Color warning = Color(0xFFD97706);
  static const Color success = Color(0xFF059669);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryGreen,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryGreen,
        secondary: primaryGreen.withOpacity(0.8),
        background: background,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textDark),
        bodyMedium: TextStyle(color: textDark),
        bodySmall: TextStyle(color: textLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
