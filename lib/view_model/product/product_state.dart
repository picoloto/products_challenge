import 'package:products_challenge/model/product/product_model.dart';

sealed class ProductState {}

class EmptyProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {
  final List<Product> products;
  SuccessProductState(this.products);
}

class ErrorProductState extends ProductState {
  final Exception exception;

  ErrorProductState(this.exception);
}
