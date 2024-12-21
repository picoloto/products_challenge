import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/product_tile_widget.dart';
import 'package:products_challenge/shared/widgets/separator_widget.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';

class ProductsFavoritesView extends StatelessWidget {
  ProductsFavoritesView({super.key});
  final productsLocalStore = getIt.get<ProductsLocalStore>();

  @override
  Widget build(BuildContext context) {
    productsLocalStore.findAllFavorites();

    void handleError() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.errorView);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Observer(builder: (_) {
        final state = productsLocalStore.state;

        if (state is ErrorProductsLocalState) {
          handleError();
        } else if (state is LoadingProductsLocalState) {
          return LoadingWidget();
        } else if (state is SuccessProductsLocalState) {
          if (state.products.isEmpty) {
            return AlertInformationWidget(
              assetPathImage: 'assets/images/empty.png',
              title: 'The list is empty',
            );
          }
          return _SuccessWidget(
            successProductsLocalState: state,
          );
        }

        return SizedBox.shrink();
      }),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  final SuccessProductsLocalState successProductsLocalState;

  const _SuccessWidget({required this.successProductsLocalState});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: successProductsLocalState.products.length,
      itemBuilder: (_, index) {
        final product = successProductsLocalState.products[index];
        return ProductTileWidget(
          product: product,
        );
      },
      separatorBuilder: (_, __) => SeparatorWidget(),
    );
  }
}
