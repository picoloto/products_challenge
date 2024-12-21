import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/service/product_local/product_local_service.dart';
import 'package:products_challenge/service/rest/rest_service.dart';
import 'package:products_challenge/view_model/product_details/product_details_store.dart';
import 'package:products_challenge/view_model/products/products_store.dart';
import 'package:products_challenge/view_model/products_local/products_local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

abstract class GetItLocator {
  static void setup() {
    _registerServices();
    _registerStores();
  }

  static void _registerServices() {
    getIt
      ..registerLazySingleton<Dio>(() => Dio())
      ..registerLazySingleton<SharedPreferencesAsync>(
          () => SharedPreferencesAsync())
      ..registerLazySingleton<RestService>(() => RestService())
      ..registerLazySingleton<ProductService>(() => ProductService())
      ..registerLazySingleton<ProductLocalService>(() => ProductLocalService());
  }

  static void _registerStores() {
    getIt
      ..registerLazySingleton<ProductDetailsStore>(() => ProductDetailsStore())
      ..registerLazySingleton<ProductsStore>(() => ProductsStore())
      ..registerLazySingleton<ProductsLocalStore>(() => ProductsLocalStore());
  }
}
