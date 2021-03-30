import 'package:json_annotation/json_annotation.dart';

part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails {
  final String productId;
  final double quantity;

  ProductDetails({this.productId, this.quantity});

  factory ProductDetails.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}
