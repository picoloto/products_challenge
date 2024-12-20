import 'package:products_challenge/model/product/product_model.dart';

sealed class ProductsState {}

class EmptyProductsState extends ProductsState {}

class LoadingProductsState extends ProductsState {}

class SuccessProductsState extends ProductsState {
  final List<Product> products;

  SuccessProductsState(this.products);
}

class ErrorProductsState extends ProductsState {
  final Exception exception;

  ErrorProductsState(this.exception);
}
