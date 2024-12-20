import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductLocalService {
  final String path = 'products';

  final SharedPreferencesAsync sharedPreferences =
      getIt.get<SharedPreferencesAsync>();

  Future<List<Product>> _getStoredProducts() async {
    try {
      final response = await sharedPreferences.getStringList(path);
      return response
              ?.map((product) => Product.fromJson(jsonDecode(product)))
              .toList() ??
          [];
    } catch (error, stackTrace) {
      debugPrint('Failed to fetch products: $error\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<void> _saveProducts(List<Product> products) async {
    try {
      final encodedProducts =
          products.map((product) => json.encode(product)).toList();
      await sharedPreferences.setStringList(path, encodedProducts);
    } catch (error, stackTrace) {
      debugPrint('Failed to save products: $error\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Future<List<Product>> findAllFavorites() async {
    return _getStoredProducts();
  }

  Future<List<Product>> toggleProductFavorite(Product product) async {
    try {
      final products = await _getStoredProducts();

      if (products.contains(product)) {
        products.remove(product);
      } else {
        products.add(product);
      }

      await _saveProducts(products);
      return products;
    } catch (error, stackTrace) {
      debugPrint('Failed to toggle favorite: $error\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}
