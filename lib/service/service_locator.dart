import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products_challenge/service/product/product_service.dart';

abstract class ServiceLocator {
  static final getIt = GetIt.instance;

  static setup() {
    getIt.registerLazySingleton<ProductService>(() => ProductService());
    getIt.registerLazySingleton<Dio>(() => Dio());
  }
}
