import 'package:flutter/material.dart';
import 'package:products_challenge/routes/router.dart';
import 'package:products_challenge/service/service_locator.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';

void main() {
  ServiceLocator.setupServices();
  runApp(const MyApp());
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
