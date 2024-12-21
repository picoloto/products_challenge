import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/service/product_local/product_local_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/product_mock.dart';
import 'products_local_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductLocalService>()])
void main() {
  late ProductsLocalStore productsLocalStore;
  late MockProductLocalService mockProductLocalService;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetItLocator.setup();
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    mockProductLocalService = MockProductLocalService();
    productsLocalStore = ProductsLocalStore();
    productsLocalStore.service = mockProductLocalService;
  });

  group('ProductsLocalStore', () {
    test('Should start with LoadingProductsLocalState', () {
      expect(productsLocalStore.state, isA<LoadingProductsLocalState>());
    });

    test(
        'Should change to SuccessProductsLocalState when adding product to favorites',
        () async {
      final product = ProductMock.product1;

      when(mockProductLocalService.toggleProductFavorite(product)).thenAnswer(
        (_) async => [product],
      );

      await productsLocalStore.addProductFavorite(product);

      expect(productsLocalStore.state, isA<SuccessProductsLocalState>());
      final successState =
          productsLocalStore.state as SuccessProductsLocalState;
      expect(successState.products, contains(product));
    });

    test(
        'Should change to ErrorProductsLocalState if an exception occurs when adding product to favorites',
        () async {
      final product = ProductMock.product1;

      when(mockProductLocalService.toggleProductFavorite(product))
          .thenThrow(Exception('Error adding favorite'));

      await productsLocalStore.addProductFavorite(product);

      expect(productsLocalStore.state, isA<ErrorProductsLocalState>());
      final errorState = productsLocalStore.state as ErrorProductsLocalState;
      expect(
          errorState.exception.toString(), contains('Error adding favorite'));
    });

    test('Should change to SuccessProductsLocalState when loading bookmarks',
        () async {
      final products = ProductMock.products;

      when(mockProductLocalService.findAllFavorites())
          .thenAnswer((_) async => products);
      await productsLocalStore.findAllFavorites();

      expect(productsLocalStore.state, isA<SuccessProductsLocalState>());
      final successState =
          productsLocalStore.state as SuccessProductsLocalState;
      expect(successState.products, equals(products));
    });

    test(
        'Should change to ErrorProductsLocalState if an exception occurs when loading bookmarks',
        () async {
      when(mockProductLocalService.findAllFavorites())
          .thenThrow(Exception('Error loading favorites'));
      await productsLocalStore.findAllFavorites();

      expect(productsLocalStore.state, isA<ErrorProductsLocalState>());
      final errorState = productsLocalStore.state as ErrorProductsLocalState;
      expect(
          errorState.exception.toString(), contains('Error loading favorites'));
    });

    test('Should check if a product is favorited correctly', () {
      final product = ProductMock.product1;
      productsLocalStore.products = [product];

      expect(productsLocalStore.isFavorite(product), isTrue);
    });

    test('Should return false if the product is not a favorite', () {
      final product = ProductMock.product1;
      productsLocalStore.products = [];

      expect(productsLocalStore.isFavorite(product), isFalse);
    });
  });
}
