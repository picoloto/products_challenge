import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/service/rest/rest_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

import '../../mocks/product_mock.dart';
import 'product_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RestService>()])
void main() {
  group('ProductService', () {
    late ProductService productService;
    late MockRestService mockRestService;
    final path = 'products';

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      GetItLocator.setup();
      productService = ProductService();
      mockRestService = MockRestService();
      productService.restService = mockRestService;
    });

    test('findAll should return a list of products', () async {
      when(mockRestService.fetchData<List<Product>>(
        path,
        any,
      )).thenAnswer((_) async => ProductMock.products);

      final result = await productService.findAll();

      await expectLater(result.length, 2);
      await expectLater(result[0].id, 1);
      await expectLater(result[0].title, 'Product 1');
      await expectLater(result[0].price, 109.95);
    });

    test('findAll throws exception on error', () async {
      when(mockRestService.fetchData<List<Product>>(
        path,
        any,
      )).thenThrow(Exception('Network error'));

      expect(() => productService.findAll(), throwsException);
    });

    test('findById should return a product', () async {
      final int id = 1;
      when(mockRestService.fetchData<Product>(
        '$path/$id',
        any,
      )).thenAnswer((_) async => ProductMock.product1);

      final result = await productService.findById(id);

      await expectLater(result.id, 1);
      await expectLater(result.title, 'Product 1');
      await expectLater(result.price, 109.95);
    });

    test('findById throws exception on error', () async {
      final int id = 1;
      when(mockRestService.fetchData<Product>(
        '$path/$id',
        any,
      )).thenThrow(Exception('Network error'));

      expect(() => productService.findById(id), throwsException);
    });
  });
}
