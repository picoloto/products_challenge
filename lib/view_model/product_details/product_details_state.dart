import 'package:products_challenge/model/product/product_model.dart';

sealed class ProductDetailsState {}

class LoadingProductDetailsState extends ProductDetailsState {}

class SuccessProductDetailsState extends ProductDetailsState {
  final Product product;

  SuccessProductDetailsState(this.product);
}

class ErrorProductDetailsState extends ProductDetailsState {
  final Exception exception;

  ErrorProductDetailsState(this.exception);
}
