import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/model/utils/debouncer.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/service/service_locator.dart';
import 'package:products_challenge/view_model/products/products_state.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  final _service = getIt.get<ProductService>();
  final _debouncer = Debouncer(milliseconds: 600);

  @observable
  ProductsState state = EmptyProductsState();

  List<Product> _products = [];

  @action
  void _loadState() => state = LoadingProductsState();

  @action
  void _successState(List<Product> products) =>
      state = SuccessProductsState(products);

  @action
  void _errorState(Exception e) => state = ErrorProductsState(e);

  @action
  void _emptyState() {
    state = EmptyProductsState();
  }

  Future<void> findProducts() async {
    _loadState();

    try {
      _products = await _service.findAll();
      if (_products.isEmpty) {
        _emptyState();
      } else {
        _successState(_products);
      }
    } on Exception catch (e, _) {
      _errorState(e);
    }
  }

  Future<void> findProductById() async {
    _loadState();

    try {
      _products = await _service.findAll();
      if (_products.isEmpty) {
        _emptyState();
      } else {
        _successState(_products);
      }
    } on Exception catch (e, _) {
      _errorState(e);
    }
  }

  Future<void> findProductsByTitle(String title) async {
    _loadState();

    try {
      _debouncer.run(() {
        List<Product> searchedProducts = _products
            .where((product) =>
                product.title.toLowerCase().contains(title.toLowerCase()))
            .toList();
        if (searchedProducts.isEmpty) {
          _emptyState();
        } else {
          _successState(searchedProducts);
        }
      });
    } on Exception catch (e, _) {
      _errorState(e);
    }
  }
}
