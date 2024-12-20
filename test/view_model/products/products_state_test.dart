import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/view_model/products/products_state.dart';

import '../../mocks/product_mock.dart';

void main() {
  group('ProductsState', () {
    test('EmptyProductsState should be instantiated correctly', () {
      final state = EmptyProductsState();

      expect(state, isA<EmptyProductsState>());
    });

    test('LoadingProductsState should be instantiated correctly', () {
      final state = LoadingProductsState();

      expect(state, isA<LoadingProductsState>());
    });

    test('SuccessProductsState should be instantiated with a list of products',
        () {
      final products = ProductMock.products;
      final state = SuccessProductsState(products);

      expect(state, isA<SuccessProductsState>());
      expect(state.products, products);
    });

    test('ErrorProductsState should be instantiated with an exception', () {
      final exception = Exception('Error loading products');
      final state = ErrorProductsState(exception);

      expect(state, isA<ErrorProductsState>());
      expect(state.exception, exception);
    });
  });
}
