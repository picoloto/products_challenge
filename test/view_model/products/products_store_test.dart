import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/products/products_state.dart';
import 'package:products_challenge/view_model/products/products_store.dart';

import '../../mocks/product_mock.dart';
import 'products_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductService>()])
void main() {
  late ProductsStore productsStore;
  late MockProductService mockProductService;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetItLocator.setup();
    mockProductService = MockProductService();
    productsStore = ProductsStore();
    productsStore.service = mockProductService;
  });

  group('ProductsStore', () {
    test('Should start with EmptyProductsState', () {
      expect(productsStore.state, isA<EmptyProductsState>());
    });

    test('Should change to EmptyProductsState if no products are found',
        () async {
      when(mockProductService.findAll()).thenAnswer((_) async => []);

      await productsStore.findProducts();

      expect(productsStore.state, isA<EmptyProductsState>());
    });

    test(
        'Should change to ErrorProductsState if an exception occurs when fetching products',
        () async {
      when(mockProductService.findAll())
          .thenThrow(Exception('Error loading products'));

      await productsStore.findProducts();

      expect(productsStore.state, isA<ErrorProductsState>());
      final errorState = productsStore.state as ErrorProductsState;
      expect(
          errorState.exception.toString(), contains('Error loading products'));
    });

    test('Should debounce correctly when searching for products by title',
        () async {
      when(mockProductService.findAll()).thenAnswer(
        (_) async => ProductMock.products,
      );

      await productsStore.findProducts();

      await productsStore.findProductsByTitle('Product 1');

      await Future.delayed(Duration(milliseconds: 650));

      expect(productsStore.state, isA<SuccessProductsState>());
      final successState = productsStore.state as SuccessProductsState;
      expect(successState.products.length, 1);
      expect(successState.products[0].title, 'Product 1');
    });

    test(
        'Should change to EmptyProductsState if no products are found when searching by title',
        () async {
      when(mockProductService.findAll()).thenAnswer(
        (_) async => [ProductMock.product1],
      );

      await productsStore.findProducts();
      await productsStore.findProductsByTitle('Nonexistent');
      await Future.delayed(Duration(milliseconds: 650));

      expect(productsStore.state, isA<EmptyProductsState>());
    });

    test(
        'Should ensure debounce is canceled when calling findProductsByTitle quickly',
        () async {
      when(mockProductService.findAll()).thenAnswer(
        (_) async => ProductMock.products,
      );

      await productsStore.findProducts();

      productsStore.findProductsByTitle('Product');
      productsStore.findProductsByTitle('Product 1');

      await Future.delayed(Duration(milliseconds: 650));

      expect(productsStore.state, isA<SuccessProductsState>());
      final successState = productsStore.state as SuccessProductsState;
      expect(successState.products.length, 1);
      expect(successState.products[0].title, 'Product 1');
    });
  });
}
