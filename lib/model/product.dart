import 'package:hamstring_design/model/cart.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hamstring_design/model/user_rating.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  String id;
  String name;
  String model;
  String description;
  String price;
  String company;
  List productImages;
  double ratings;
  double numberOfTimesProductRated;
  UserRating userRating;
  bool favourite;
  bool addedToCart;
  bool userCanRate;
  bool userRated;
  Cart cart;

  Product(
      {this.id,
      this.name,
      this.model,
      this.price,
      this.description,
      this.company,
      this.productImages,
      this.ratings,
      this.userRating,
      this.numberOfTimesProductRated,
      this.favourite = false,
      this.addedToCart = false,
      this.userCanRate = false,
      this.userRated = false,
      this.cart});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
