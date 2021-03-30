import 'package:json_annotation/json_annotation.dart';

import 'package:hamstring_design/model/product.dart';

part 'order_items.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItems {
  Product product;
  double quantity;

  OrderItems({this.product, this.quantity});

  factory OrderItems.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
}
