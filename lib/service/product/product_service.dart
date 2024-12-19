import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/shared/environments/environment_dev.dart';

class ProductService {
  final dio = GetIt.instance.get<Dio>();

  Future<List<Product>> findAll() async {
    final List<Product> products = [];

    try {
      final response =
          await dio.get<List<dynamic>>('${EnvironmentDev.restApiUrl}/products');

      for (var data in response.data!) {
        products.add(
          Product.fromJson(
              jsonDecode(jsonEncode(data)) as Map<String, dynamic>),
        );
      }

      return Future.value(products);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      throw Exception('Failed to load data');
    }
  }
}
