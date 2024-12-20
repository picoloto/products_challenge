import 'package:flutter/material.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';

class AlertInformationWidget extends StatelessWidget {
  final String title;
  final String assetPathImage;

  const AlertInformationWidget({
    super.key,
    required this.assetPathImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPathImage,
            width: 160,
            height: 160,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: AppColors.neutral65,
            ),
          )
        ],
      ),
    );
  }
}
