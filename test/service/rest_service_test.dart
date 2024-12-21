import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/rest/rest_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

import '../mocks/product_mock.dart';
import 'rest_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  late RestService restService;
  late MockDio mockDio;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetItLocator.setup();
    restService = RestService();
    mockDio = MockDio();

    restService.dio = mockDio;
  });

  group('RestService', () {
    test('findAll should return a list of products', () async {
      when(mockDio.get(any)).thenAnswer((_) async => Future.value(Response(
          requestOptions: RequestOptions(),
          data: jsonDecode(jsonEncode(ProductMock.product1)))));

      final result = await restService.fetchData('products/1',
          (data) => Product.fromJson(data as Map<String, dynamic>));

      await expectLater(result.id, 1);
      await expectLater(result.title, 'Product 1');
      await expectLater(result.price, 109.95);
    });
  });
}
