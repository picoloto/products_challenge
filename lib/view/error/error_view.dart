import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/shared/constants/routes.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Image.asset(
                    'assets/images/error.png',
                    width: 160,
                    height: 160,
                  ),
                  Text(
                    'Something went wrong!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff7d878c),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.go(productsViewRoute),
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
