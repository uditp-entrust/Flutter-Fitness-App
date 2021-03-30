// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    id: json['id'] as String,
    userId: json['userId'] as String,
    productId: json['productId'] as String,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    productCount: (json['productCount'] as num)?.toDouble(),
    totalPrice: (json['totalPrice'] as num)?.toDouble(),
    favourite: json['favourite'] as bool,
    ratings: (json['ratings'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'product': instance.product?.toJson(),
      'productCount': instance.productCount,
      'totalPrice': instance.totalPrice,
      'favourite': instance.favourite,
      'ratings': instance.ratings,
    };
