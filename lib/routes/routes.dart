import 'package:go_router/go_router.dart';
import 'package:products_challenge/shared/constants/routes.dart';
import 'package:products_challenge/view/error/error_view.dart';
import 'package:products_challenge/view/product/product_details_view.dart';
import 'package:products_challenge/view/product/products_favorites_view.dart';
import 'package:products_challenge/view/product/products_view.dart';

final router = GoRouter(
  initialLocation: productsViewRoute,
  routes: [
    GoRoute(
      path: productsViewRoute,
      builder: (context, state) => ProductsView(),
    ),
    GoRoute(
      path: productDetailsViewRoute,
      builder: (context, state) => ProductDetailsView(),
    ),
    GoRoute(
      path: productsFavoritesViewRoute,
      builder: (context, state) => ProductsFavoritesView(),
    ),
    GoRoute(
      path: errorViewRoute,
      builder: (context, state) => ErrorView(),
    ),
  ],
);
