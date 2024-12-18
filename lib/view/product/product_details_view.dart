import 'package:flutter/material.dart';
import 'package:products_challenge/shared/widgets/app_bar_title.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Product Details'),
      ),
      body: Container(),
    );
  }
}
