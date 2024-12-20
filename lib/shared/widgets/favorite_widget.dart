import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';

class FavoriteWidget extends StatelessWidget {
  final productsLocalStore = getIt.get<ProductsLocalStore>();
  final Product product;
  final MaterialTapTargetSize materialTapTargetSize;

  FavoriteWidget({
    super.key,
    required this.product,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 24,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
      style: ButtonStyle(tapTargetSize: materialTapTargetSize),
      onPressed: () => productsLocalStore.addProductFavorite(product),
      icon: Observer(
        builder: (context) {
          final state = productsLocalStore.state;

          if (state is SuccessProductsLocalState) {
            return Icon(
              productsLocalStore.isFavorite(product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: productsLocalStore.isFavorite(product)
                  ? AppColors.error
                  : AppColors.neutralDarker,
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
