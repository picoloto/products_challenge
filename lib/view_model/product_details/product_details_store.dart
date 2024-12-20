import 'package:mobx/mobx.dart';
import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/product/product_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';
import 'package:products_challenge/view_model/product_details/product_details_state.dart';

part 'product_details_store.g.dart';

class ProductDetailsStore = ProductDetailsStoreBase with _$ProductDetailsStore;

abstract class ProductDetailsStoreBase with Store {
  ProductService service = getIt.get<ProductService>();

  @observable
  ProductDetailsState state = LoadingProductDetailsState();

  @action
  void _setLoadingState() => state = LoadingProductDetailsState();

  @action
  void _setSuccessState(Product product) =>
      state = SuccessProductDetailsState(product);

  @action
  void _setErrorState(Exception e) => state = ErrorProductDetailsState(e);

  Future<void> findProductById(int id) async {
    _setLoadingState();

    try {
      final product = await service.findById(id);
      _setSuccessState(product);
    } on Exception catch (e, _) {
      _setErrorState(e);
    }
  }
}
