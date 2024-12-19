import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/widgets/alert_title.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Center(
              child: AlertInformation(
                assetPathImage: 'assets/images/error.png',
                title: 'Something went wrong!',
              ),
            ),
            TextButton(
              onPressed: () => context.go(Routes.productsView),
              child: Text(
                'Go Home',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
