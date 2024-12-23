import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/shared/utils/debouncer.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/products/products_state.dart';

part 'products_store.g.dart';

class ProductsStore = ProductsStoreBase with _$ProductsStore;

abstract class ProductsStoreBase with Store {
  ProductService service = getIt.get<ProductService>();
  Debouncer debouncer = Debouncer(milliseconds: 600);

  List<Product> products = [];

  @observable
  ProductsState state = EmptyProductsState();

  @action
  void _setLoadingState() => state = LoadingProductsState();

  @action
  void _setSuccessState(List<Product> products) =>
      state = SuccessProductsState(products);

  @action
  void _setErrorState(Exception e) => state = ErrorProductsState(e);

  @action
  void _setEmptyState() => state = EmptyProductsState();

  Future<void> _fetchAndUpdateState(
      Future<List<Product>> Function() fetcher) async {
    _setLoadingState();

    try {
      products = await fetcher();
      if (products.isEmpty) {
        _setEmptyState();
      } else {
        _setSuccessState(products);
      }
    } on Exception catch (e) {
      _setErrorState(e);
    }
  }

  Future<void> findProducts() async {
    await _fetchAndUpdateState(() => service.findAll());
  }

  Future<void> findProductsByTitle(String title) async {
    _setLoadingState();

    debouncer.call(() {
      List<Product> searchedProducts = products
          .where((product) =>
              product.title.toLowerCase().contains(title.toLowerCase()))
          .toList();
      if (searchedProducts.isEmpty) {
        _setEmptyState();
      } else {
        _setSuccessState(searchedProducts);
      }
    });
  }
}
