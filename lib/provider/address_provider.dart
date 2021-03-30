import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:http/http.dart' as http;

import '../model/address.dart';

class AddressProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  final String authToken;
  final String userId;

  List<Address> _userAddresses = [];

  List<Address> get userAddresses {
    return [..._userAddresses];
  }

  AddressProvider(this.authToken, this.userId);

  Future<void> addNewAddress(Map address) async {
    print('called from provider $address');
    try {
      final response = await http.post(
        '$url/address',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode({
          'userId': userId,
          'userName': address['userName'],
          'phoneNumber': address['phoneNumber'],
          'latitude': address['latitude'],
          'longitude': address['longitude'],
          'houseNumber': address['house'],
          'landmark': address['landmark'],
          'addressType': address['addressType'],
          'area': address['area'],
          'city': address['city'],
          'state': address['state'],
          'country': address['country'],
          'type': "Point",
          'location': address['location']
        }),
      );
      print('New address added ${jsonDecode(response.body)}');
    } catch (err) {
      print('failed to add new address $err');
      throw err;
    }
  }

  Future<void> updateAddress(String addressId, Map address) async {
    try {
      final response = await http.patch(
        '$url/address/$addressId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode({
          'userId': userId,
          'userName': address['userName'],
          'phoneNumber': address['phoneNumber'],
          'latitude': address['latitude'],
          'longitude': address['longitude'],
          'houseNumber': address['house'],
          'landmark': address['landmark'],
          'addressType': address['addressType'],
          'area': address['area'],
          'city': address['city'],
          'state': address['state'],
          'country': address['country'],
          'type': "Point",
          'location': address['location']
        }),
      );
      print('New address added ${jsonDecode(response.body)}');
    } catch (err) {
      print('failed to add new address $err');
      throw err;
    }
  }

  Future<void> getUserAddress() async {
    try {
      final response = await http.get(
        '$url/address/user/$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );

      if (response.statusCode >= 400) {
        print('server side ${jsonDecode(response.body)}');
        return;
      }

      final responseData = jsonDecode(response.body);
      if (responseData == null) {
        return;
      }

      print('user address list  $responseData');

      _userAddresses.clear();
      responseData.forEach((address) {
        _userAddresses.add(Address(
            id: address['_id'],
            userId: address['userId'],
            userName: address['userName'],
            phoneNumber: address['phoneNumber'],
            latitiude: address['latitude'] == null
                ? 0.0
                : address['latitude'].toDouble(),
            longitude: address['longitude'] == null
                ? 0.0
                : address['longitude'].toDouble(),
            houseNumber: address['houseNumber'],
            landmark: address['landmark'],
            addressType: address['addressType'],
            area: address['area'],
            city: address['city'],
            state: address['state'],
            country: address['country'],
            type: address['type'],
            location: address['location']));
      });

      notifyListeners();
    } catch (err) {
      print('failed to get user addresses $err');
      throw err;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    _userAddresses.removeWhere((item) => item.id == addressId);

    notifyListeners();

    try {
      final response = await http.delete('$url/address/$addressId',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          });
    } catch (err) {
      print('failed to remove item $err');
      throw err;
    }
  }
}
