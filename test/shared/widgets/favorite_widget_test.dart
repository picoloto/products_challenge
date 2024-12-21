import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/shared/widgets/favorite_widget.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/product_mock.dart';
import 'favorite_widget_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductsLocalStore>(),
  MockSpec<ProductsLocalState>(),
  MockSpec<ErrorProductsLocalState>(),
  MockSpec<LoadingProductsLocalState>(),
  MockSpec<SuccessProductsLocalState>(),
])
void main() {
  late MockProductsLocalStore mockProductsLocalStore;
  final Product testProduct = ProductMock.product1;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    mockProductsLocalStore = MockProductsLocalStore();
    GetItLocator.setup();
  });

  setUp(() {
    mockito
        .when(mockProductsLocalStore.state)
        .thenReturn(SuccessProductsLocalState(ProductMock.products));
    mockito
        .when(mockProductsLocalStore.isFavorite(testProduct))
        .thenReturn(false);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: FavoriteWidget(
          product: testProduct,
          productsLocalStore: mockProductsLocalStore,
        ),
      ),
    );
  }

  group('FavoriteWidget', () {
    testWidgets('Should renders favorite icon correctly when not favorited',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('Should renders favorite icon correctly when favorited',
        (WidgetTester tester) async {
      mockito
          .when(mockProductsLocalStore.isFavorite(testProduct))
          .thenReturn(true);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('Should calls addProductFavorite when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      mockito
          .verify(mockProductsLocalStore.addProductFavorite(testProduct))
          .called(1);
    });

    testWidgets('Should updates correctly when state changes',
        (WidgetTester tester) async {
      final state = Observable(SuccessProductsLocalState(ProductMock.products));
      mockito.when(mockProductsLocalStore.state).thenAnswer((_) => state.value);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      mockito
          .when(mockProductsLocalStore.isFavorite(testProduct))
          .thenReturn(true);

      reaction((_) => mockProductsLocalStore.state, (state) {
        if (state is SuccessProductsLocalState) {
          expect(state.products, ProductMock.products);
        }
      });

      state.reportChanged();
      await tester.pump();

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}
