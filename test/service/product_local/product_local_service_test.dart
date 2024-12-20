import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:products_challenge/service/product_local/product_local_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../mocks/product_mock.dart';
import 'product_local_service_test.mocks.dart';

@GenerateMocks([SharedPreferencesAsync])
void main() {
  late MockSharedPreferencesAsync mockSharedPreferences;
  late ProductLocalService productLocalService;

  group('ProductLocalService', () {
    final testProduct = ProductMock.product1;
    final encodedTestProduct = jsonEncode(testProduct);

    setUpAll(() {
      WidgetsFlutterBinding.ensureInitialized();
      GetItLocator.setup();
      mockSharedPreferences = MockSharedPreferencesAsync();
      getIt.registerSingleton<SharedPreferencesAsync>(mockSharedPreferences);

      productLocalService = ProductLocalService();
    });

    test('findAllFavorites deve retornar produtos armazenados', () async {
      // Arrange
      when(mockSharedPreferences.getStringList('products'))
          .thenAnswer((_) async => Future.value([encodedTestProduct]));

      // Act
      final products = await productLocalService.findAllFavorites();

      // Assert
      expect(products, isNotEmpty);
      expect(products.first, equals(testProduct));
    });

    test(
        'findAllFavorites deve retornar uma lista vazia se não houver produtos',
        () async {
      // Arrange
      when(mockSharedPreferences.getStringList('products'))
          .thenAnswer((_) async => Future.value([]));

      // Act
      final products = await productLocalService.findAllFavorites();

      // Assert
      expect(products, isEmpty);
    });

    test('toggleProductFavorite deve adicionar um produto favorito', () async {
      // Arrange
      when(mockSharedPreferences.getStringList('products'))
          .thenAnswer((_) async => Future.value([]));

      // Act
      final updatedProducts =
          await productLocalService.toggleProductFavorite(testProduct);

      // Assert
      verify(mockSharedPreferences.setStringList(
        'products',
        [encodedTestProduct],
      )).called(1);

      expect(updatedProducts, contains(testProduct));
    });

    test('toggleProductFavorite deve remover um produto favorito existente',
        () async {
      // Arrange
      when(mockSharedPreferences.getStringList('products'))
          .thenAnswer((_) async => Future.value([encodedTestProduct]));

      // Act
      final updatedProducts =
          await productLocalService.toggleProductFavorite(testProduct);

      // Assert
      verify(mockSharedPreferences.setStringList('products', [])).called(1);

      expect(updatedProducts, isEmpty);
    });
  });
}
