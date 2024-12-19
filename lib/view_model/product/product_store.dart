import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/model/utils/debouncer.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/view_model/product/product_state.dart';

part 'product_store.g.dart';

class ProductStore = ProductStoreBase with _$ProductStore;

abstract class ProductStoreBase with Store {
  final _productService = GetIt.instance.get<ProductService>();
  final _debouncer = Debouncer(milliseconds: 600);

  @observable
  ProductState state = EmptyProductState();

  List<Product> _products = [];

  @action
  void _loadState() {
    state = LoadingProductState();
  }

  @action
  void _successState(List<Product> products) {
    state = SuccessProductState(products);
  }

  @action
  void _errorState(Exception e) {
    state = ErrorProductState(e);
  }

  Future<void> findProducts() async {
    _loadState();

    try {
      _products = await _productService.findAll();
      _successState(_products);
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
        _successState(searchedProducts);
      });
    } on Exception catch (e, _) {
      _errorState(e);
    }
  }
}
