import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_challenge/routes/router.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

void main() {
  initializeApp();
  runApp(const MyApp());
}

void initializeApp() {
  WidgetsFlutterBinding.ensureInitialized();
  GetItLocator.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Products Challenge',
      theme: ThemeData(
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
      ),
      routerConfig: router,
    );
  }
}
