import 'package:flutter/material.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.neutralLight,
    );
  }
}
