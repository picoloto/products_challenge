import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/service/service_locator.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';

part 'product_details_store.g.dart';

class ProductsDetailsStore = ProductsDetailsStoreBase
    with _$ProductsDetailsStore;

abstract class ProductsDetailsStoreBase with Store {
  final _service = getIt.get<ProductService>();

  @observable
  ProductDetailsState state = LoadingProductDetailsState();

  @action
  void _loadState() => state = LoadingProductDetailsState();

  @action
  void _successState(Product product) =>
      state = SuccessProductDetailsState(product);

  @action
  void _errorState(Exception e) => state = ErrorProductDetailsState(e);

  Future<void> findProductById(int id) async {
    _loadState();

    try {
      final product = await _service.findById(id);
      _successState(product);
    } on Exception catch (e, _) {
      _errorState(e);
    }
  }
}
