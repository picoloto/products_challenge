import 'package:flutter_test/flutter_test.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';

import '../../mocks/product_mock.dart';

void main() {
  group('ProductDetailsState', () {
    test('LoadingProductDetailsState should be instantiated correctly', () {
      final state = LoadingProductDetailsState();

      expect(state, isA<LoadingProductDetailsState>());
    });

    test('SuccessProductDetailsState should be instantiated with a product',
        () {
      final product = ProductMock.product1;
      final state = SuccessProductDetailsState(product);

      expect(state, isA<SuccessProductDetailsState>());
      expect(state.product, product);
    });

    test('ErrorProductDetailsState should be instantiated with an exception',
        () {
      final exception = Exception('Error loading product');
      final state = ErrorProductDetailsState(exception);

      expect(state, isA<ErrorProductDetailsState>());
      expect(state.exception, exception);
    });
  });
}
