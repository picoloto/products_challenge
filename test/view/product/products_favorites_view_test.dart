import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/product_tile_widget.dart';
import 'package:products_challenge/view/product/products_favorites_view.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/product_mock.dart';
import 'products_favorites_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsLocalStore>(),
])
void main() {
  late MockProductsLocalStore mockProductsLocalStore;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    GetItLocator.setup();
  });

  setUp(() {
    mockProductsLocalStore = MockProductsLocalStore();

    getIt.unregister<ProductsLocalStore>();

    getIt.registerLazySingleton<ProductsLocalStore>(
        () => mockProductsLocalStore);
  });

  group('ProductsFavoritesView', () {
    testWidgets('Should display LoadWidget while loading bookmarks',
        (tester) async {
      when(mockProductsLocalStore.state)
          .thenReturn(LoadingProductsLocalState());

      await tester.pumpWidget(
        MaterialApp(
          home: ProductsFavoritesView(),
        ),
      );

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Should Display error message when getting favorites failed',
        (tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => ProductsFavoritesView(),
          ),
          GoRoute(
            path: Routes.errorView,
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: Text('error')),
              body: Center(child: Text('Error View')),
            ),
          ),
        ],
      );

      when(mockProductsLocalStore.state).thenAnswer(
          (_) => ErrorProductsLocalState(Exception('Error fetching data')));

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      verify(mockProductsLocalStore.findAllFavorites()).called(1);

      await tester.pumpAndSettle();
      expect(find.text('Error View'), findsOneWidget);
    });

    testWidgets('Should Display alert message when favorites list is empty',
        (tester) async {
      when(mockProductsLocalStore.state)
          .thenReturn(SuccessProductsLocalState([]));

      await tester.pumpWidget(
        MaterialApp(
          home: ProductsFavoritesView(),
        ),
      );

      expect(find.byType(AlertInformationWidget), findsOneWidget);
      expect(find.text('The list is empty'), findsOneWidget);
    });

    testWidgets('Should Display the favorites list when there are products',
        (tester) async {
      provideMockedNetworkImages(() async {
        final product = ProductMock.product1;

        when(mockProductsLocalStore.state)
            .thenReturn(SuccessProductsLocalState([product]));

        await tester.pumpWidget(
          MaterialApp(
            home: ProductsFavoritesView(),
          ),
        );

        expect(find.byType(ProductTileWidget), findsOneWidget);
        expect(find.text('Product 1'), findsOneWidget);
      });
    });
  });
}
