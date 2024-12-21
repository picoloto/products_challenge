import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/rest/rest_service.dart';
import 'package:products_challenge/shared/utils/get_it_locator.dart';

class ProductService implements RestServiceInterface {
  RestService restService = getIt.get<RestService>();
  final String path = 'products';

  @override
  Future<List<Product>> findAll() async {
    return restService.fetchData<List<Product>>(
      path,
      (data) => (data as List)
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Product> findById(int id) async {
    return restService.fetchData<Product>(
      '$path/$id',
      (data) => Product.fromJson(data as Map<String, dynamic>),
    );
  }
}
