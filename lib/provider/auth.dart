import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/http_expection.dart';
import 'package:hamstring_design/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;

  bool get isAuthenticated {
    return _token != null;
  }

  String get token {
    return _token;
  }

  String get userId {
    return _userId;
  }

  Future<void> loginUser(String email, String password) async {
    print('login user $email $password');
    try {
      final response = await http.post(
        '$API_URL/api/auth/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (responseData['validationErrorMessage'] != null) {
        throw HttpException(responseData['validationErrorMessage']);
      }
      _token = responseData['token'];
      _userId = responseData['user']['_id'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
        <String, String>{
          'token': _token,
          'userId': _userId,
        },
      );
      prefs.setString('userData', userData);
    } catch (err) {
      print('failed to login $err');
      throw err;
    }
  }

  Future<void> signupUser(User authData) async {
    try {
      final response = await http.post(
        '$API_URL/api/auth/register',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': authData.firstName,
          'lastName': authData.lastName,
          'email': authData.email,
          'phoneNumber': authData.phoneNumber,
          'password': authData.password,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (responseData['validationErrorMessage'] != null) {
        throw HttpException(responseData['validationErrorMessage']);
      }

      notifyListeners();
    } catch (err) {
      print('failed to signup user $err');
      throw err;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final token = extractedUserData['token'];
    print('try auto login $token');
    if (token == null) {
      return false;
    }
    _token = token;
    _userId = extractedUserData['userId'];

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      final response = await http.post(
        '$API_URL/api/auth/forgotpassword',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      final responseData = jsonDecode(response.body);
      if (responseData['validationErrorMessage'] != null) {
        throw HttpException(responseData['validationErrorMessage']);
      }
    } catch (err) {
      print('failed to login $err');
      throw err;
    }
  }
}
