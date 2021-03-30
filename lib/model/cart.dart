import 'package:json_annotation/json_annotation.dart';

import 'package:hamstring_design/model/product.dart';

part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  @JsonKey(name: '_id')
  final String id;

  final String userId;
  final String productId;
  final Product product;
  double productCount;
  double totalPrice;
  bool favourite;
  final double ratings;

  Cart(
      {this.id,
      this.userId,
      this.productId,
      this.product,
      this.productCount,
      this.totalPrice,
      this.favourite = false,
      this.ratings});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
