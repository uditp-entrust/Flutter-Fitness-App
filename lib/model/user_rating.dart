import 'package:json_annotation/json_annotation.dart';

part 'user_rating.g.dart';

@JsonSerializable()
class UserRating {
  String id;
  String userId;
  String productId;
  double rating;
  String review;

  UserRating({this.id, this.userId, this.productId, this.rating, this.review});

  factory UserRating.fromJson(Map<String, dynamic> json) =>
      _$UserRatingFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingToJson(this);
}
