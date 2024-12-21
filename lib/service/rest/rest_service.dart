import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:products_challenge/shared/environments/environment_dev.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

abstract interface class RestServiceInterface {
  Future<dynamic> findAll();

  Future<dynamic> findById(int id);

  // Implementar os outros métodos rest, como post, delete, update...
}

class RestService {
  String baseUrl = Environment.restApiUrlDev;
  Dio dio = getIt.get<Dio>();

  Future<T> fetchData<T>(
    String path,
    T Function(dynamic data) transform,
  ) async {
    try {
      final response = await dio.get('$baseUrl/$path');
      if (response.data == null) {
        throw Exception('Failed to load data');
      }
      return transform(response.data);
    } catch (error, stackTrace) {
      debugPrint('Exception occurred: $error\nStackTrace: $stackTrace');
      rethrow;
    }
  }
}
