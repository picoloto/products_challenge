import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/shared/constants/routes.dart';
import 'package:products_challenge/shared/widgets/app_bar_title.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 47,
        titleSpacing: 16,
        title: AppBarTitle(title: 'Products'),
        actions: [
          IconButton(
            onPressed: () =>
                GoRouter.of(context).push(productsFavoritesViewRoute),
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
