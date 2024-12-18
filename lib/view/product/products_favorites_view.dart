import 'package:flutter/material.dart';
import 'package:products_challenge/shared/widgets/app_bar_title.dart';

class ProductsFavoritesView extends StatelessWidget {
  const ProductsFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'ProductsFavoritesView'),
      ),
      body: Container(),
    );
  }
}
