import 'package:flutter/material.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';

class RateWidget extends StatelessWidget {
  final double rate;
  final int reviewCount;

  const RateWidget({super.key, required this.rate, required this.reviewCount});

  String _getReviewWord() {
    if (reviewCount == 1) {
      return 'review';
    }

    return 'reviews';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 9,
      children: [
        Icon(
          Icons.star,
          color: AppColors.attentionLighter,
          size: 22,
        ),
        Expanded(
          child: Text(
            '${rate.toStringAsFixed(1)} (${reviewCount.toString()} ${_getReviewWord()})',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.neutral65,
            ),
          ),
        ),
      ],
    );
  }
}
