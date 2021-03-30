import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  List<Cart> _cartList = [];
  double _totalAmount = 0.0;

  List<Cart> get cartList {
    return [..._cartList];
  }

  double get totalAmount {
    return _totalAmount;
  }

  final String authToken;
  final String userId;

  CartProvider(this.authToken, this.userId);

  Future<void> addNewItemToCart(String productId, double totalPrice) async {
    try {
      final response = await http.post(
        '$url/cart',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode({
          'userId': userId,
          'productId': productId,
          'productCount': 1,
          'totalPrice': totalPrice,
        }),
      );
      print('product added to cart');
    } catch (err) {
      print('failed to add cart $err');
      throw err;
    }
  }

  Future<void> addItem(
      double currentQuantity, String cartItemId, double itemPrice) async {
    final cartItemIndex = _cartList.indexWhere((item) => item.id == cartItemId);
    _cartList[cartItemIndex].productCount = currentQuantity + 1;
    _cartList[cartItemIndex].totalPrice = itemPrice * (currentQuantity + 1);

    notifyListeners();

    try {
      final response = await http.patch(
        '$url/cart/$cartItemId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode(<String, double>{
          'productCount': currentQuantity + 1,
          'totalPrice': itemPrice * (currentQuantity + 1),
        }),
      );
      print('add Item ${jsonDecode(response.body)}');
    } catch (err) {
      print('failed to add list $err');
      throw err;
    }
  }

  // Future<void> clearCart() {
  //   try {
  //     final response = await http.delete(
  //       '$url/cart/$cartItemId',
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': authToken,
  //       },
  //       body: jsonEncode(<String, double>{
  //         'productCount': currentQuantity + 1,
  //         'totalPrice': itemPrice * (currentQuantity + 1),
  //       }),
  //     );
  //   } catch (err) {
  //     print('faled to clear cart $err');
  //     throw err;
  //   }
  // }

  Future<void> emptyCart(List<String> cartIds) async {
    _cartList.clear();
    for (var i = 0; i < cartIds.length; i++) {
      final response = await http.delete('$url/cart/${cartIds[i]}',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          });
    }
  }

  Future<void> removeItem(double currentQuantity, String cartItemId,
      double itemPrice, bool removeAll) async {
    if (removeAll == true) {
      _cartList.removeWhere((item) => item.id == cartItemId);
    } else {
      if (currentQuantity == 1) {
        _cartList.removeWhere((item) => item.id == cartItemId);
      } else {
        final cartItemIndex =
            _cartList.indexWhere((item) => item.id == cartItemId);
        _cartList[cartItemIndex].productCount = currentQuantity - 1;
        _cartList[cartItemIndex].totalPrice = itemPrice * (currentQuantity - 1);
      }
    }

    notifyListeners();

    try {
      if (removeAll == true) {
        print('function called for remove all');
        final response = await http.delete('$url/cart/$cartItemId',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': authToken
            });
      } else {
        if (currentQuantity == 1) {
          final response = await http.delete('$url/cart/$cartItemId',
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': authToken
              });
        } else {
          final response = await http.patch(
            '$url/cart/$cartItemId',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': authToken
            },
            body: jsonEncode(<String, double>{
              'productCount': currentQuantity - 1,
              'totalPrice': itemPrice * (currentQuantity - 1),
            }),
          );
        }
      }
    } catch (err) {
      print('failed to remove item $err');
      throw err;
    }
  }

  Future<void> getUserCart() async {
    try {
      final response = await http.get(
        '$url/cart/$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );

      if (response.statusCode >= 400) {
        print('server side');
        return;
      }

      final responseData = jsonDecode(response.body);
      if (responseData == null) {
        return;
      }

      _cartList.clear();
      responseData.forEach((cart) {
        final cartItemIndex =
            _cartList.indexWhere((cartItem) => cartItem.id == cart['_id']);
        _cartList.add(Cart(
          id: cart['_id'],
          userId: cart['userId'],
          productId: cart['productId'],
          productCount: cart['productCount'] == null
              ? 0.0
              : cart['productCount'].toDouble(),
          totalPrice:
              cart['totalPrice'] == null ? 0.0 : cart['totalPrice'].toDouble(),
          favourite: cart['favourite'],
          ratings: cart['ratings'] == null ? 0.0 : cart['ratings'].toDouble(),
          product: Product(
              id: cart['product'][0]['_id'],
              name: cart['product'][0]['name'],
              model: cart['product'][0]['model'],
              price: cart['product'][0]['price'],
              description: cart['product'][0]['description'],
              company: cart['product'][0]['company'],
              productImages: cart['product'][0]['productImages'] == null
                  ? []
                  : [...cart['product'][0]['productImages']]),
        ));
      });

      notifyListeners();
    } catch (err) {
      print('failed to get cart $err');
      throw err;
    }
  }
}
