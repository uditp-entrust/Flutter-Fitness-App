import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:http/http.dart' as http;

import '../model/http_expection.dart';

class User with ChangeNotifier {
  final String url = '$API_URL/api/auth/user/';
  Map<String, String> _userDetails = {};

  Map<String, String> get userDetail {
    return {..._userDetails};
  }

  final String authToken;
  final String userId;

  User(this.authToken, this.userId);

  Future<void> getUserById() async {
    print('user get by id $userId');
    try {
      final response = await http.get(
        '$url$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      _userDetails = {
        '_id': responseData['_id'],
        'firstName': responseData['firstName'],
        'lastName': responseData['lastName'],
        'phoneNumber': responseData['phoneNumber'],
        'email': responseData['email']
      };
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateUser(Map<String, String> user) async {
    print('updated user $user');
    try {
      final response = await http.patch('$url$userId',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          },
          body: jsonEncode(<String, String>{
            'firstName': user['firstName'],
            'lastName': user['lastName'],
            'email': user['email'],
            'password': user['password'],
          }));
      final responseData = jsonDecode(response.body);
      if (responseData['validationErrorMessage'] != null) {
        throw HttpException(responseData['validationErrorMessage']);
      }
      print('uname ${responseData['firstName']}');
      _userDetails = {
        '_id': responseData['_id'],
        'firstName': responseData['firstName'],
        'lastName': responseData['lastName'],
        'phoneNumber': responseData['phoneNumber'],
        'email': responseData['email']
      };
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
