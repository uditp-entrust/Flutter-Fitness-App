// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    id: json['_id'] as String,
    userId: json['userId'] as String,
    product: (json['product'] as List)
        ?.map((e) => e == null
            ? null
            : ProductDetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPrice: (json['totalAmount'] as num)?.toDouble(),
    address: json['address'] as String,
    paymentType: json['paymentType'] as String,
    deliveryCharge: (json['deliveryCharge'] as num)?.toDouble(),
    userAddress: json['userAddress'] == null
        ? null
        : Address.fromJson(json['userAddress'] as Map<String, dynamic>),
    addressId: json['addressId'] as String,
    productList: (json['productList'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    orderItems: (json['orderItems'] as List)
        ?.map((e) =>
            e == null ? null : OrderItems.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'product': instance.product?.map((e) => e?.toJson())?.toList(),
      'productList': instance.productList?.map((e) => e?.toJson())?.toList(),
      'totalAmount': instance.totalPrice,
      'address': instance.address,
      'userAddress': instance.userAddress?.toJson(),
      'addressId': instance.addressId,
      'paymentType': instance.paymentType,
      'deliveryCharge': instance.deliveryCharge,
      'createdAt': instance.createdAt?.toIso8601String(),
      'orderItems': instance.orderItems?.map((e) => e?.toJson())?.toList(),
    };
