import 'package:flutter/material.dart';
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
      theme: CustomTheme.themeData(context),
      routerConfig: router,
    );
  }
}
