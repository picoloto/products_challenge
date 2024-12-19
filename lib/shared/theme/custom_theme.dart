import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final class CustomTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        color: neutralLighter,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: CustomTheme.neutral,
          fontSize: 20,
        ),
      ),
      scaffoldBackgroundColor: neutralLighter,
      colorSchemeSeed: primary,
    );
  }

  static const primary = Color(0xFF3366CC);
  static const attention = Color(0xffF37A20);
  static const attentionLighter = Color(0xffFFD700);
  static const success = Color(0xFF5EC401);
  static const error = Color(0xFFFF0000);

  static const neutral = Color(0xff37474F);

  static const neutral80 = Color(0xCC37474F);
  static const neutral65 = Color(0xA637474F);

  static const neutralLighter = Colors.white;

  static const neutralDark = Color(0xff3E3E3E);
  static const neutralDarker = Colors.black;
}
