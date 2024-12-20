import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/service/product_local/product_local_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import '../../mocks/product_mock.dart';
import 'product_local_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferencesAsync>()])
void main() {
  late SharedPreferencesAsync mockSharedPreferences;
  late ProductLocalService productLocalService;
  final path = 'products';

  group('ProductLocalService', () {
    final testProduct = ProductMock.product1;
    final encodedTestProduct = jsonEncode(testProduct);

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      GetItLocator.setup();
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();

      mockSharedPreferences = MockSharedPreferencesAsync();
      productLocalService = ProductLocalService();

      productLocalService.sharedPreferences = mockSharedPreferences;
    });

    test(
        'findAllFavorites should return an empty list if there are no products',
        () async {
      when(mockSharedPreferences.getStringList(path))
          .thenAnswer((_) async => Future.value([]));

      final products = await productLocalService.findAllFavorites();

      expect(products, isEmpty);
    });

    test('findAllFavorites must return stored products', () async {
      when(mockSharedPreferences.getStringList(path))
          .thenAnswer((_) async => Future.value([encodedTestProduct]));

      final products = await productLocalService.findAllFavorites();

      expect(products, isNotEmpty);
      expect(products.first, equals(testProduct));
    });

    test('toggleProductFavorite should remove an existing favorite product',
        () async {
      when(mockSharedPreferences.getStringList(path))
          .thenAnswer((_) async => Future.value([encodedTestProduct]));

      final products =
          await productLocalService.toggleProductFavorite(testProduct);

      expect(products, isEmpty);
    });

    test('toggleProductFavorite should add a favorite product', () async {
      when(mockSharedPreferences.getStringList(path))
          .thenAnswer((_) async => Future.value([]));

      final products =
          await productLocalService.toggleProductFavorite(testProduct);

      expect(products, contains(testProduct));
    });
  });
}
