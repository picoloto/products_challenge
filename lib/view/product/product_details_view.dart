import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/favorite_widget.dart';
import 'package:products_challenge/shared/widgets/icon_text_widget.dart';
import 'package:products_challenge/shared/widgets/image_network_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';
import 'package:products_challenge/view_model/product_details/product_details_store.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';

class ProductDetailsView extends StatelessWidget {
  final int productId;

  final productDetailsStore = getIt.get<ProductDetailsStore>();
  final productsLocalStore = getIt.get<ProductsLocalStore>();

  ProductDetailsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    productDetailsStore.findProductById(productId);

    void handleError() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.errorView);
      });
    }

    return Observer(builder: (context) {
      final state = productDetailsStore.state;

      return Scaffold(
        appBar: AppBar(
          title: Text('Product Details'),
          actions: [
            Builder(
              builder: (_) {
                if (state is SuccessProductDetailsState) {
                  return FavoriteWidget(
                    product: state.product,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    productsLocalStore: productsLocalStore,
                  );
                }

                return SizedBox.shrink();
              },
            )
          ],
        ),
        body: SafeArea(
          child: Builder(
            builder: (_) {
              if (state is LoadingProductDetailsState) {
                return LoadingWidget();
              } else if (state is ErrorProductDetailsState) {
                handleError();
              } else if (state is SuccessProductDetailsState) {
                final product = state.product;
                return _SuccessWidget(
                  product: product,
                );
              }

              return SizedBox.shrink();
            },
          ),
        ),
      );
    });
  }
}

class _SuccessWidget extends StatelessWidget {
  final Product product;
  const _SuccessWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          spacing: 22,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageNetworkWidget(
              imageUrl: product.image,
              width: 322,
              height: 322,
            ),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.neutralDarker,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RateWidget(
                    rate: product.rating.rate,
                    reviewCount: product.rating.count,
                  ),
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w800,
                    fontSize: 29,
                  ),
                ),
              ],
            ),
            IconTextWidget(
              icon: Icons.sort,
              text: product.category,
            ),
            IconTextWidget(
              icon: Icons.menu,
              text: product.description,
            ),
          ],
        ),
      ),
    );
  }
}
