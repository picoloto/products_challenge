import 'package:products_challenge/model/product/product_model.dart';

import 'rating_mock.dart';

class ProductMock {
  static Product get product1 => Product(
        id: 1,
        title: "Product 1",
        price: 109.95,
        description: "Description product 1",
        category: "Category Product 1",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: RatingMock.rating1,
      );

  static Product get product2 => Product(
        id: 2,
        title: "Product 2",
        price: 22.3,
        description: "Description product 2",
        category: "Category Product 2",
        image:
            "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: RatingMock.rating2,
      );

  static List<Product> get products {
    return [product1, product2];
  }
}
