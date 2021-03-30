// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) {
  return OrderItems(
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    quantity: (json['quantity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'product': instance.product?.toJson(),
      'quantity': instance.quantity,
    };
