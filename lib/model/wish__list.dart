import 'package:hamstring_design/model/product.dart';

class WishList {
  final String id;
  final String userId;
  final String productId;
  final Product product;

  WishList({this.id, this.userId, this.productId, this.product});
}
