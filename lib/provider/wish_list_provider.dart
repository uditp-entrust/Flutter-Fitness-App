import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/model/wish__list.dart';
import 'package:http/http.dart' as http;

class WishListProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  List<WishList> _favouriteList = [];

  List<WishList> get favouriteList {
    return [..._favouriteList];
  }

  final String authToken;
  final String userId;

  WishListProvider(this.authToken, this.userId);

  Future<void> getFavouriteByUse() async {
    try {
      final response = await http.get(
        '$url/favourite/$userId',
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
      print('favorite items list $responseData');
      if (responseData == null) {
        return;
      }
      _favouriteList.clear();
      responseData.forEach((favourite) {
        final favouriteItemIndex = _favouriteList.indexWhere(
            (favouriteItem) => favouriteItem.id == favourite['_id']);
        _favouriteList.add(WishList(
          id: favourite['_id'],
          userId: favourite['userId'],
          productId: favourite['productId'],
          product: new Product(
              id: favourite['product'][0]['_id'],
              name: favourite['product'][0]['name'],
              model: favourite['product'][0]['model'],
              price: favourite['product'][0]['price'],
              description: favourite['product'][0]['description'],
              company: favourite['product'][0]['company'],
              productImages: favourite['product'][0]['productImages'] == null
                  ? []
                  : [...favourite['product'][0]['productImages']]),
        ));
      });

      notifyListeners();
    } catch (err) {
      print('failed to get user #err');
      throw err;
    }
  }

  Future<void> removeFavouriteItem(String productId) async {
    List<WishList> favouriteItemList = [..._favouriteList];
    WishList itemToRemove =
        favouriteItemList.firstWhere((item) => item.productId == productId);
    final favouriteItemIndex = _favouriteList
        .indexWhere((favouriteItem) => favouriteItem.productId == productId);
    try {
      if (favouriteItemIndex != -1) {
        _favouriteList.removeAt(favouriteItemIndex);
      }

      notifyListeners();

      final response = await http.delete('$url/favourite/$userId/$productId',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          });
      if (response.statusCode >= 400) {
        Fluttertoast.showToast(
            msg: "Failed To remove favourite item",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
        _favouriteList.add(itemToRemove);
      }
    } catch (err) {
      print('faield to post favourite $err');
      Fluttertoast.showToast(
          msg: "Failed To remove favourite item",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      _favouriteList.add(itemToRemove);
    }
  }
}
