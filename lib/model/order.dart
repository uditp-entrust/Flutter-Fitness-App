import 'package:hamstring_design/model/order_items.dart';
import 'package:hamstring_design/model/product_details.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hamstring_design/model/address.dart';
import 'package:hamstring_design/model/product.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(name: '_id')
  String id;

  String userId;
  List<ProductDetails> product;
  List<Product> productList;

  @JsonKey(name: 'totalAmount')
  double totalPrice;

  String address;
  Address userAddress;
  String addressId;
  String paymentType;
  double deliveryCharge;
  DateTime createdAt;
  List<OrderItems> orderItems;

  Order(
      {this.id,
      this.userId,
      this.product,
      this.totalPrice,
      this.address,
      this.paymentType,
      this.deliveryCharge,
      this.userAddress,
      this.addressId,
      this.productList,
      this.createdAt,
      this.orderItems});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
