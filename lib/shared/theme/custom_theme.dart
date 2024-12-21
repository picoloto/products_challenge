import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class CustomTheme {
  static ThemeData themeData() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        color: AppColors.neutralLighter,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.neutral,
          fontSize: 20,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: AppColors.neutralLighter,
      colorSchemeSeed: AppColors.primary,
    );
  }
}

final class AppColors {
  static const Color primary = Color(0xFF3366CC);
  static const Color attention = Color(0xffF37A20);
  static const Color attentionLighter = Color(0xffFFD700);
  static const Color success = Color(0xFF5EC401);
  static const Color error = Color(0xFFFF0000);

  static const Color neutral = Color(0xff37474F);
  static const Color neutral65 = Color(0xA637474F);
  static const Color neutral80 = Color(0xCC37474F);

  static const Color neutralLight = Color(0xFFF0F0F0);
  static const Color neutralLighter = Colors.white;

  static const Color neutralDark = Color(0xff3E3E3E);
  static const Color neutralDarker = Colors.black;
}
