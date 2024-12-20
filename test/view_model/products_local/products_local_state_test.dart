import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';

import '../../mocks/product_mock.dart';

void main() {
  group('ProductsLocalState', () {
    test('LoadingProductsLocalState should be instantiated correctly', () {
      final state = LoadingProductsLocalState();

      expect(state, isA<LoadingProductsLocalState>());
    });

    test(
        'SuccessProductsLocalState must be instantiated with a list of products',
        () {
      final products = ProductMock.products;
      final state = SuccessProductsLocalState(products);

      expect(state, isA<SuccessProductsLocalState>());
      expect(state.products, products);
    });

    test('ErrorProductsLocalState must be instantiated with an exception', () {
      final exception = Exception('Error loading products');
      final state = ErrorProductsLocalState(exception);

      expect(state, isA<ErrorProductsLocalState>());
      expect(state.exception, exception);
    });
  });
}
