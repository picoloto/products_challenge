import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products_challenge/service/product/product_service.dart';

final getIt = GetIt.instance;

abstract class ServiceLocator {
  static setupServices() {
    getIt.registerLazySingleton<ProductService>(() => ProductService());
    getIt.registerLazySingleton<Dio>(() => Dio());
  }
}
