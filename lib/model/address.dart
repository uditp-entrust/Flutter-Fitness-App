import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String id;
  String userId;
  double latitiude;
  double longitude;
  String houseNumber;
  String landmark;
  String addressType;
  String area;
  String city;
  String state;
  String country;
  String userName;
  String phoneNumber;
  List location;
  String type;

  Address(
      {this.id,
      this.userId,
      this.latitiude,
      this.longitude,
      this.houseNumber,
      this.landmark,
      this.addressType,
      this.area,
      this.city,
      this.country,
      this.state,
      this.userName,
      this.phoneNumber,
      this.location,
      this.type});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
