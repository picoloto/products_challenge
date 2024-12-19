import 'package:flutter/material.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        Icon(
          icon,
          size: 24,
          color: CustomTheme.neutralDark,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: CustomTheme.neutralDark,
            ),
          ),
        ),
      ],
    );
  }
}
