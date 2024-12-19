import 'package:flutter/material.dart';

class AlertInformation extends StatelessWidget {
  final String title;
  final String assetPathImage;

  const AlertInformation(
      {super.key, required this.assetPathImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
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
            color: Color(0xff7d878c),
          ),
        )
      ],
    );
  }
}
