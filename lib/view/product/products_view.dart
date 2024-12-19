import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/theme/custom_theme.dart';
import 'package:products_challenge/shared/widgets/alert_title.dart';
import 'package:products_challenge/shared/widgets/app_bar_title.dart';
import 'package:products_challenge/view_model/product/product_state.dart';
import 'package:products_challenge/view_model/product/product_store.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final productStore = ProductStore();
    productStore.findProducts();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 47,
        titleSpacing: 16,
        title: AppBarTitle(title: 'Products'),
        actions: [
          IconButton(
            onPressed: () =>
                GoRouter.of(context).push(Routes.productsFavoritesView),
            icon: Icon(
              Icons.favorite_border,
              color: CustomTheme.neutral65,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  onChanged: (String value) =>
                      productStore.findProductsByTitle(value),
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
                    fillColor: Color(0xFFF0F1F2),
                  ),
                ),
              ),
              Flexible(
                child: Observer(
                  builder: (_) {
                    final state = productStore.state;

                    Widget widget = Container();

                    if (state is EmptyProductState) {
                      widget = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertInformation(
                            assetPathImage: 'assets/images/empty.png',
                            title: 'The list is empty',
                          ),
                        ],
                      );
                    } else if (state is ErrorProductState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        GoRouter.of(context).go(Routes.errorView);
                      });
                    } else if (state is LoadingProductState) {
                      widget = Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SuccessProductState) {
                      widget = ListView.separated(
                        itemCount: state.products.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(18),
                            child: ComponenteInicial(
                              product: state.products[index],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return Divider(
                            color: Color(0xFFF0F0F0),
                          );
                        },
                      );
                    } else {}

                    return widget;
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

class ComponenteInicial extends StatelessWidget {
  Product product;

  ComponenteInicial({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 18,
      children: [
        SizedBox(
          width: 126,
          height: 126,
          child: Image.network(
            product.image,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return Center(child: child);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Expanded(
          child: Column(
            spacing: 9,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: CustomTheme.neutral,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 9,
                      children: [
                        Icon(
                          Icons.star,
                          color: CustomTheme.attentionLighter,
                          size: 22,
                        ),
                        Text(
                          '${product.rating.rate.toString()} (${product.rating.count.toString()} reviews)',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: CustomTheme.neutral65,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.favorite_border,
                    size: 24,
                  ),
                ],
              ),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: CustomTheme.attention,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
