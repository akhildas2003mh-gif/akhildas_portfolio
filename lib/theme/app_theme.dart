import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colour palette taken from the reference design: white / ice-blue surfaces,
/// a strong royal blue for actions and a Flutter-cyan accent.
class AppColors {
  AppColors._();

  static const primary = Color(0xFF0A5BD8);
  static const primaryDark = Color(0xFF0847A8);
  static const cyan = Color(0xFF13B9FD);
  static const ink = Color(0xFF0B1220);
  static const body = Color(0xFF475467);
  static const bg = Color(0xFFF6F9FF);
  static const soft = Color(0xFFEAF2FF);
  static const border = Color(0xFFE2EAF7);
}

class AppText {
  AppText._();

  static TextStyle heading(
    double size, {
    Color color = AppColors.ink,
    FontWeight weight = FontWeight.w700,
  }) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: 1.15,
        letterSpacing: -0.5,
      );

  static TextStyle body(
    double size, {
    Color color = AppColors.body,
    FontWeight weight = FontWeight.w400,
    double height = 1.7,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.bg,
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.body,
        displayColor: AppColors.ink,
      ),
    );
  }
}
