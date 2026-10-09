import 'package:flutter/material.dart';

class CivicColors {
  // Brand Primary & Accent
  static const Color primary = Color(0xFF5B36F5);
  static const Color primaryDark = Color(0xFF4318FF);
  static const Color primaryLight = Color(0xFF7551FF);
  static const Color primarySoft = Color(0xFFEEF2FF);
  static const Color primaryBorder = Color(0xFFC7D2FE);

  // Mint / Green / Verified
  static const Color mint = Color(0xFF00D09C);
  static const Color mintLight = Color(0xFFA7F3D0);
  static const Color mintDark = Color(0xFF065F46);
  static const Color mintBadgeBg = Color(0xFFD1FAE5);

  // Urgent / Error / Alert
  static const Color urgentRed = Color(0xFFEF4444);
  static const Color urgentRedBg = Color(0xFFFEE2E2);
  static const Color urgentRedText = Color(0xFF991B1B);
  static const Color timerPinkBg = Color(0xFFFFE4E6);
  static const Color timerPinkText = Color(0xFFBE123C);

  // Cyan / Telemetry
  static const Color cyan = Color(0xFF06B6D4);
  static const Color cyanLight = Color(0xFF80EED2);
  static const Color cyanBg = Color(0xFFE0F2FE);

  // Neutral Light
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Neutral Dark
  static const Color bgDark = Color(0xFF0B0F19);
  static const Color cardDark = Color(0xFF161F30);
  static const Color cardSurfaceDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF2E3D52);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4F32E5), Color(0xFF7042F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient reportCardGradient = LinearGradient(
    colors: [Color(0xFF4F36E3), Color(0xFF6842EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardGradient = LinearGradient(
    colors: [Color(0xFF3B28CC), Color(0xFF5B36F5)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: CivicColors.bgLight,
    primaryColor: CivicColors.primary,
    colorScheme: const ColorScheme.light(
      primary: CivicColors.primary,
      secondary: CivicColors.mint,
      surface: CivicColors.cardLight,
      error: CivicColors.urgentRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: CivicColors.textPrimaryLight,
    ),
    cardColor: CivicColors.cardLight,
    dividerColor: CivicColors.borderLight,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: CivicColors.bgLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: CivicColors.textPrimaryLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CivicColors.bgDark,
    primaryColor: CivicColors.primaryLight,
    colorScheme: const ColorScheme.dark(
      primary: CivicColors.primaryLight,
      secondary: CivicColors.mint,
      surface: CivicColors.cardDark,
      error: CivicColors.urgentRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: CivicColors.textPrimaryDark,
    ),
    cardColor: CivicColors.cardDark,
    dividerColor: CivicColors.borderDark,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: CivicColors.bgDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: CivicColors.textPrimaryDark),
    ),
  );
}
