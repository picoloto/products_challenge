import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/service/rest_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

import '../../mocks/product_mock.dart';
import 'product_service_test.mocks.dart';

// class MockDio extends Mock implements Dio {}

@GenerateMocks([Dio, ProductService, RestService])
void main() {
  group('ProductService', () {
    late ProductService productService;

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      GetItLocator.setup();
      productService = MockProductService();
    });

    group('ProductService', () {
      test('findAll should return a list of products', () async {
        final List<Product> mockData = ProductMock.products;

        when(productService.findAll())
            .thenAnswer((_) => Future.value(mockData));

        final result = await productService.findAll();

        expect(result.length, 2);
        expect(result[0].id, 1);
        expect(result[0].title,
            'Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops');
        expect(result[0].price, 109.95);
      });

      test('findById throws exception on error', () async {
        final int id = 1;
        when(productService.findById(id)).thenThrow(Exception('Network error'));

        expect(() => productService.findById(id), throwsException);
      });
    });
  });
}
