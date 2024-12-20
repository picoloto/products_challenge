import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/shared/widgets/favorite_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/product_tile_widget.dart';
import 'package:products_challenge/shared/widgets/separator_widget.dart';
import 'package:products_challenge/view_model/products/products_state.dart';
import 'package:products_challenge/view_model/products/products_store.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';

final productsStore = getIt.get<ProductsStore>();
final productsLocalStore = getIt.get<ProductsLocalStore>();

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    productsStore.findProducts();
    productsLocalStore.findAllFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleError() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.errorView);
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 47,
        titleSpacing: 16,
        title: Text('Products'),
        actions: [
          IconButton(
            onPressed: () =>
                GoRouter.of(context).push(Routes.productsFavoritesView),
            icon: Icon(
              Icons.favorite_border,
              color: AppColors.neutralDarker,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Column(
            spacing: 18,
            children: [
              _SearchWidget(),
              Expanded(
                child: Observer(
                  builder: (_) {
                    final state = productsStore.state;

                    if (state is EmptyProductsState) {
                      return AlertInformationWidget(
                        assetPathImage: 'assets/images/empty.png',
                        title: 'The list is empty',
                      );
                    } else if (state is ErrorProductsState) {
                      handleError();
                    } else if (state is LoadingProductsState) {
                      return LoadingWidget();
                    } else if (state is SuccessProductsState) {
                      return _SuccessWidget(
                        successProductsState: state,
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        onChanged: (String value) => productsStore.findProductsByTitle(value),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search Anything',
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          fillColor: AppColors.neutralLight,
        ),
      ),
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  final SuccessProductsState successProductsState;

  const _SuccessWidget({required this.successProductsState});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: successProductsState.products.length,
      itemBuilder: (_, index) {
        final product = successProductsState.products[index];
        return InkWell(
          onTap: () => GoRouter.of(context)
              .push('${Routes.productDetailsView}/${product.id}'),
          child: ProductTileWidget(
            product: product,
            favoriteWidget: FavoriteWidget(product: product),
          ),
        );
      },
      separatorBuilder: (_, __) => SeparatorWidget(),
    );
  }
}
