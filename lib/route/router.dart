import 'package:go_router/go_router.dart';
import 'package:products_challenge/route/routes.dart';
import 'package:products_challenge/view/error/error_view.dart';
import 'package:products_challenge/view/product/product_details_view.dart';
import 'package:products_challenge/view/product/products_favorites_view.dart';
import 'package:products_challenge/view/product/products_view.dart';

final router = GoRouter(
  initialLocation: Routes.productsView,
  routes: [
    GoRoute(
      path: Routes.productsView,
      builder: (context, state) => ProductsView(),
    ),
    GoRoute(
      path: '${Routes.productDetailsView}/:productId',
      builder: (context, state) {
        final int productId =
            int.tryParse(state.pathParameters['productId']!) ?? 0;
        return ProductDetailsView(productId: productId);
      },
    ),
    GoRoute(
      path: Routes.productsFavoritesView,
      builder: (context, state) => ProductsFavoritesView(),
    ),
    GoRoute(
      path: Routes.errorView,
      builder: (context, state) => ErrorView(),
    ),
  ],
);
