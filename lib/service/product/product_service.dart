import 'package:products_challenge/model/product/product_model.dart';
import 'package:products_challenge/service/rest_service.dart';

class ProductService extends RestService implements RestServiceInterface {
  final String path = 'products';

  @override
  Future<List<Product>> findAll() async {
    return fetchData<List<Product>>(
      path,
      (data) => (data as List)
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<Product> findById(int id) async {
    return fetchData<Product>(
      '$path/$id',
      (data) => Product.fromJson(data as Map<String, dynamic>),
    );
  }
}
