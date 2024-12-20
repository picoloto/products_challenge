import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product_local/product_local_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/products_local/products_local_state.dart';

part 'products_local_store.g.dart';

class ProductsLocalStore = ProductsLocalStoreBase with _$ProductsLocalStore;

abstract class ProductsLocalStoreBase with Store {
  ProductLocalService service = getIt.get<ProductLocalService>();

  List<Product> products = [];

  @observable
  ProductsLocalState state = LoadingProductsLocalState();

  @action
  void _setLoadingState() => state = LoadingProductsLocalState();

  @action
  void _setSuccessState(List<Product> products) =>
      state = SuccessProductsLocalState(products);

  @action
  void _setErrorState(Exception e) => state = ErrorProductsLocalState(e);

  Future<void> _fetchAndUpdateState(
      Future<List<Product>> Function() fetcher) async {
    try {
      products = await fetcher();
      _setSuccessState(products);
    } on Exception catch (e) {
      _setErrorState(e);
    }
  }

  Future<void> addProductFavorite(Product product) async {
    await _fetchAndUpdateState(() => service.toggleProductFavorite(product));
  }

  Future<void> findAllFavorites() async {
    _setLoadingState();
    await _fetchAndUpdateState(() => service.findAllFavorites());
  }

  bool isFavorite(Product product) => products.contains(product);
}
