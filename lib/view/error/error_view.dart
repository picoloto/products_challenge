import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/route/routes.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';

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
              child: AlertInformationWidget(
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
