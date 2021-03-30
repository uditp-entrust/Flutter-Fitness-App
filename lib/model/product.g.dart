// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    name: json['name'] as String,
    model: json['model'] as String,
    price: json['price'] as String,
    description: json['description'] as String,
    company: json['company'] as String,
    productImages: json['productImages'] as List,
    ratings: (json['ratings'] as num)?.toDouble(),
    userRating: json['userRating'] == null
        ? null
        : UserRating.fromJson(json['userRating'] as Map<String, dynamic>),
    numberOfTimesProductRated:
        (json['numberOfTimesProductRated'] as num)?.toDouble(),
    favourite: json['favourite'] as bool,
    addedToCart: json['addedToCart'] as bool,
    userCanRate: json['userCanRate'] as bool,
    userRated: json['userRated'] as bool,
    cart: json['cart'] == null
        ? null
        : Cart.fromJson(json['cart'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'model': instance.model,
      'description': instance.description,
      'price': instance.price,
      'company': instance.company,
      'productImages': instance.productImages,
      'ratings': instance.ratings,
      'numberOfTimesProductRated': instance.numberOfTimesProductRated,
      'userRating': instance.userRating?.toJson(),
      'favourite': instance.favourite,
      'addedToCart': instance.addedToCart,
      'userCanRate': instance.userCanRate,
      'userRated': instance.userRated,
      'cart': instance.cart?.toJson(),
    };
