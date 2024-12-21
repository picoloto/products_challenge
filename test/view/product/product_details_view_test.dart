import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/image_test/image_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/route/routes.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/favorite_widget.dart';
import 'package:products_challenge/shared/widgets/loading_widget.dart';
import 'package:products_challenge/shared/widgets/rate_widget.dart';
import 'package:products_challenge/view/product/product_details_view.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';
import 'package:products_challenge/view_model/product_details/product_details_store.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/go_router_mock.dart';
import '../../mocks/product_mock.dart';
import 'product_details_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsLocalStore>(),
  MockSpec<ProductDetailsStore>(),
])
void main() {
  late MockProductDetailsStore mockProductDetailsStore;
  late MockProductsLocalStore mockProductsLocalStore;
  final Product product = ProductMock.product1;

  Widget getWidget() => MaterialApp(
        home: ProductDetailsView(productId: product.id),
      );

  Widget getErrorRouterWidget() => MaterialApp.router(
        routerConfig: GoRouterMock.getRouter(
          getWidget(),
          Text('Error View'),
          Routes.errorView,
        ),
      );

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    GetItLocator.setup();
  });

  setUp(() {
    mockProductDetailsStore = MockProductDetailsStore();
    mockProductsLocalStore = MockProductsLocalStore();

    getIt.unregister<ProductsLocalStore>();
    getIt.unregister<ProductDetailsStore>();

    getIt.registerLazySingleton<ProductsLocalStore>(
        () => mockProductsLocalStore);
    getIt.registerLazySingleton<ProductDetailsStore>(
        () => mockProductDetailsStore);
  });

  group('ProductDetailsView', () {
    testWidgets('Should display loading widget when data is loading',
        (WidgetTester tester) async {
      when(mockProductDetailsStore.state)
          .thenReturn(LoadingProductDetailsState());

      await tester.pumpWidget(getWidget());

      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    testWidgets('Should navigate to error view when there is an error',
        (WidgetTester tester) async {
      when(mockProductDetailsStore.state).thenAnswer(
          (_) => ErrorProductDetailsState(Exception('Error fetching data')));

      await tester.pumpWidget(getErrorRouterWidget());

      await tester.pumpAndSettle();
      expect(find.text('Error View'), findsOneWidget);
    });

    testWidgets(
        'Should display product details when data is successfully fetched',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductDetailsStore.state)
            .thenReturn(SuccessProductDetailsState(product));

        await tester.pumpWidget(getWidget());

        expect(find.text(product.title), findsOneWidget);
        expect(find.text(product.description), findsOneWidget);
        expect(
            find.text('\$${product.price.toStringAsFixed(2)}'), findsOneWidget);
        expect(find.byType(RateWidget), findsOneWidget);
        expect(find.byType(FavoriteWidget), findsOneWidget);
      });
    });

    testWidgets(
        'Should display FavoriteWidget when product details are available',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductDetailsStore.state)
            .thenReturn(SuccessProductDetailsState(product));

        await tester.pumpWidget(getWidget());

        expect(find.byType(FavoriteWidget), findsOneWidget);
      });
    });

    testWidgets('Should display correct price and category',
        (WidgetTester tester) async {
      provideMockedNetworkImages(() async {
        when(mockProductDetailsStore.state)
            .thenReturn(SuccessProductDetailsState(product));

        await tester.pumpWidget(getWidget());

        expect(find.text('\$109.95'), findsOneWidget);
        expect(find.text('Category Product 1'), findsOneWidget);
      });
    });
  });
}
