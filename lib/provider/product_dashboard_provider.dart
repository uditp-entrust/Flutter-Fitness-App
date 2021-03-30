import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:http/http.dart' as http;

class ProductDashboardProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  int _totalCartItems = 0;

  int get totalCartItems {
    return _totalCartItems;
  }

  int _totalFavouriteItems = 0;

  int get totalFavouriteItems {
    return _totalFavouriteItems;
  }

  final String authToken;
  final String userId;

  ProductDashboardProvider(this.authToken, this.userId);

  Future<void> getTotalCartItems() async {
    try {
      final response = await http.get(
        '$url/cart/count/$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      print('cart Item ${jsonDecode(response.body)}');
      _totalCartItems = responseData[0]['totalItems'];
      notifyListeners();
    } catch (err) {
      print('failed to get cart item $err');
      throw err;
    }
  }

  Future<void> getTotalFavouriteItems() async {
    try {
      final response = await http.get(
        '$url/favourite/count/$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      _totalFavouriteItems = responseData;
      notifyListeners();
    } catch (err) {
      print('failed to get cart item $err');
      throw err;
    }
  }
}
