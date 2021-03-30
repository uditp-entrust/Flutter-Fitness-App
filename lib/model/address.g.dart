// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['id'] as String,
    userId: json['userId'] as String,
    latitiude: (json['latitiude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    houseNumber: json['houseNumber'] as String,
    landmark: json['landmark'] as String,
    addressType: json['addressType'] as String,
    area: json['area'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
    state: json['state'] as String,
    userName: json['userName'] as String,
    phoneNumber: json['phoneNumber'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'latitiude': instance.latitiude,
      'longitude': instance.longitude,
      'houseNumber': instance.houseNumber,
      'landmark': instance.landmark,
      'addressType': instance.addressType,
      'area': instance.area,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
    };
