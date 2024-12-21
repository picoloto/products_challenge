import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/routes/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/alert_information_widget.dart';
import 'package:products_challenge/shared/widgets/favorite_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/product_tile_widget.dart';
import 'package:products_challenge/view/product/products_view.dart';
import 'package:products_challenge/view_model/products/products_state.dart';
import 'package:products_challenge/view_model/products/products_store.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/go_router_mock.dart';
import '../../mocks/product_mock.dart';
import 'products_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsLocalStore>(),
  MockSpec<ProductsStore>(),
])
void main() {
  late MockProductsLocalStore mockProductsLocalStore;
  late ProductsStore mockProductsStore;
  final Product product = ProductMock.product1;

  Widget getWidget() => MaterialApp(
        home: ProductsView(),
      );

  Widget getErrorRouterWidget() => MaterialApp.router(
        routerConfig: GoRouterMock.getRouter(
          getWidget(),
          Text('Error View'),
          Routes.errorView,
        ),
      );

  Widget getDetailsRouterWidget() => MaterialApp.router(
        routerConfig: GoRouterMock.getRouter(
          getWidget(),
          Text('Product Details View'),
          '${Routes.productDetailsView}/${product.id}',
        ),
      );

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    GetItLocator.setup();
  });

  setUp(() {
    mockProductsLocalStore = MockProductsLocalStore();
    mockProductsStore = MockProductsStore();

    getIt.unregister<ProductsLocalStore>();
    getIt.unregister<ProductsStore>();

    getIt.registerLazySingleton<ProductsLocalStore>(
        () => mockProductsLocalStore);
    getIt.registerLazySingleton<ProductsStore>(() => mockProductsStore);
  });

  group('ProductsView', () {
    testWidgets('Should display loading widget when data is loading',
        (WidgetTester tester) async {
      when(mockProductsStore.state).thenReturn(LoadingProductsState());

      await tester.pumpWidget(getWidget());

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Should display empty state when no products are available',
        (WidgetTester tester) async {
      when(mockProductsStore.state).thenReturn(EmptyProductsState());

      await tester.pumpWidget(getWidget());

      expect(find.byType(AlertInformationWidget), findsOneWidget);
      expect(find.text('The list is empty'), findsOneWidget);
    });

    testWidgets('Should navigate to error view when there is an error',
        (WidgetTester tester) async {
      when(mockProductsStore.state).thenAnswer(
          (_) => ErrorProductsState(Exception('Error fetching data')));

      await tester.pumpWidget(getErrorRouterWidget());

      await tester.pumpAndSettle();
      expect(find.text('Error View'), findsOneWidget);
    });

    testWidgets('Should display product list when data is successfully fetched',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductsStore.state)
            .thenReturn(SuccessProductsState([product]));

        await tester.pumpWidget(getWidget());

        expect(find.byType(ProductTileWidget), findsOneWidget);
        expect(find.text(product.title), findsOneWidget);
        expect(
            find.text('\$${product.price.toStringAsFixed(2)}'), findsOneWidget);
      });
    });

    testWidgets('Should display favorite icon on product tile',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductsStore.state)
            .thenReturn(SuccessProductsState([product]));

        await tester.pumpWidget(getWidget());

        expect(find.byType(FavoriteWidget), findsOneWidget);
      });
    });

    testWidgets('Should trigger search when user types in the search box',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductsStore.state)
            .thenReturn(SuccessProductsState([product]));

        await tester.pumpWidget(getWidget());

        await tester.enterText(find.byType(TextField), product.title);
        await tester.pump();

        verify(mockProductsStore.findProductsByTitle(product.title)).called(1);
      });
    });

    testWidgets('Should navigate to product details when a product is tapped',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductsStore.state)
            .thenReturn(SuccessProductsState([product]));

        await tester.pumpWidget(getDetailsRouterWidget());

        await tester.tap(find.byType(ProductTileWidget));
        await tester.pumpAndSettle();

        expect(find.text('Product Details View'), findsOneWidget);
      });
    });
  });
}
