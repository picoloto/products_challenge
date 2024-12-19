import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/icon_text_widget.dart';
import 'package:products_challenge/shared/widgets/image_network_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';
import 'package:products_challenge/view_model/product_details/product_details_store.dart';

class ProductDetailsView extends StatelessWidget {
  final int productId;

  final productsDetailsStore = ProductsDetailsStore();

  ProductDetailsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    productsDetailsStore.findProductById(productId);

    void handleError() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.errorView);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
              color: CustomTheme.neutralDarker,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Observer(builder: (_) {
          final state = productsDetailsStore.state;

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
        }),
      ),
    );
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
                color: CustomTheme.neutralDarker,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RateWidget(
                  rate: product.rating.rate,
                  reviewCount: product.rating.count,
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: CustomTheme.success,
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
