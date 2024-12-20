import 'package:products_challenge/model/rating/rating.dart';

class RatingMock {
  static Rating get rating1 {
    return Rating(rate: 3.9, count: 120);
  }

  static Rating get rating2 {
    return Rating(rate: 4.1, count: 259);
  }
}
