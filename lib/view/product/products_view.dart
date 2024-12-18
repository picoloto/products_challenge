import 'package:flutter/material.dart';
import 'package:products_challenge/shared/widgets/app_bar_title.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Products'),
      ),
      body: Container(),
    );
  }
}
