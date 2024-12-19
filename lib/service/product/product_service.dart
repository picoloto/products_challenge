import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/rest_service.dart';
import 'package:products_challenge/service/service_locator.dart';
import 'package:products_challenge/shared/environments/environment_dev.dart';

class ProductService extends RestService {
  final dio = getIt.get<Dio>();
  final String path = 'products';

  @override
  Future<List<Product>> findAll() async {
    final List<Product> products = [];

    try {
      final response = await dio.get('${EnvironmentDev.restApiUrl}/$path');

      if (response.data == null) {
        throw Exception(
          'Failed to load data',
        );
      }

      products.addAll(
        (response.data as List)
            .map((product) => Product.fromJson(
                jsonDecode(jsonEncode(product)) as Map<String, dynamic>))
            .toList(),
      );

      return Future.value(products);
    } on Exception catch (error, stackTrace) {
      debugPrint(
          'Exception occured: ${error.toString()}\nStackTrace: ${stackTrace.toString()}');
      rethrow;
    }
  }

  @override
  Future<Product> findById(int id) async {
    try {
      final response = await dio.get('${EnvironmentDev.restApiUrl}/$path/$id');

      if (response.data == null) {
        throw Exception(
          'Failed to load data',
        );
      }

      final product = Product.fromJson(
          jsonDecode(jsonEncode(response.data)) as Map<String, dynamic>);

      return Future.value(product);
    } on Exception catch (error, stackTrace) {
      debugPrint(
          'Exception occured: ${error.toString()}\nStackTrace: ${stackTrace.toString()}');
      rethrow;
    }
  }
}
