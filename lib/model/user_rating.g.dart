// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRating _$UserRatingFromJson(Map<String, dynamic> json) {
  return UserRating(
    id: json['id'] as String,
    userId: json['userId'] as String,
    productId: json['productId'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    review: json['review'] as String,
  );
}

Map<String, dynamic> _$UserRatingToJson(UserRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'rating': instance.rating,
      'review': instance.review,
    };
