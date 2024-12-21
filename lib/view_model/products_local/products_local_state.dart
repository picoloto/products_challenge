import 'package:products_challenge/model/product/product_model.dart';

abstract class ProductsLocalState {}

class LoadingProductsLocalState extends ProductsLocalState {}

class SuccessProductsLocalState extends ProductsLocalState {
  final List<Product> products;
  SuccessProductsLocalState(this.products);
}

class ErrorProductsLocalState extends ProductsLocalState {
  final Exception exception;

  ErrorProductsLocalState(this.exception);
}
