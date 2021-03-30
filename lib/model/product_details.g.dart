// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) {
  return ProductDetails(
    productId: json['productId'] as String,
    quantity: (json['quantity'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
