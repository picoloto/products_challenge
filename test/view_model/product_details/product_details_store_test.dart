import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';
import 'package:products_challenge/view_model/product_details/product_details_store.dart';

import '../../mocks/product_mock.dart';
import 'product_details_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductService>()])
void main() {
  late ProductDetailsStore productDetailsStore;
  late MockProductService mockProductService;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetItLocator.setup();
    mockProductService = MockProductService();
    productDetailsStore = ProductDetailsStore();
    productDetailsStore.service = mockProductService;
  });

  group('ProductDetailsStore', () {
    test('Should start with LoadingProductDetailsState', () {
      expect(productDetailsStore.state, isA<LoadingProductDetailsState>());
    });

    test('Should change to SuccessProductDetailsState when product is found',
        () async {
      final product = ProductMock.product1;

      when(mockProductService.findById(1)).thenAnswer((_) async => product);

      await productDetailsStore.findProductById(1);

      expect(productDetailsStore.state, isA<SuccessProductDetailsState>());
      final successState =
          productDetailsStore.state as SuccessProductDetailsState;
      expect(successState.product, product);
    });

    test('Should change to ErrorProductDetailsState when an exception occurs',
        () async {
      final exception = Exception('Error loading product');

      when(mockProductService.findById(1)).thenThrow(exception);

      await productDetailsStore.findProductById(1);

      expect(productDetailsStore.state, isA<ErrorProductDetailsState>());
      final errorState = productDetailsStore.state as ErrorProductDetailsState;
      expect(errorState.exception, exception);
    });
  });
}
