import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/model/user_rating.dart';
import 'package:http/http.dart' as http;

class SearchProductProvider with ChangeNotifier {
  final String url = 'http://10.0.2.2:3001/api';

  List<Product> _searchProductList = [];

  List<Product> get searchProductList {
    return [..._searchProductList];
  }

  final String authToken;
  final String userId;

  SearchProductProvider(this.authToken, this.userId);

  Future<void> searchProducts(String searchString) async {
    try {
      final response = await http.get(
        '$url/product/search/$userId/$searchString',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      print('response data befor $responseData');
      if (responseData == null) {
        return;
      }
      _searchProductList.clear();
      responseData.forEach((product) {
        _searchProductList.add(Product(
            id: product['_id'],
            name: product['name'],
            model: product['model'],
            price: product['price'],
            description: product['description'],
            company: product['company'],
            productImages: product['productImages'] == null
                ? []
                : [...product['productImages']],
            favourite: product['favourite'],
            userRating: product['userRating'] == null
                ? UserRating(userId: '', productId: '', rating: 0.0, review: '')
                : UserRating(
                    id: product['userRating']['_id'],
                    userId: product['userRating']['userId'],
                    productId: product['userRating']['productId'],
                    review: product['userRating']['review'],
                    rating: product['userRating']['rating'] == null
                        ? 0.0
                        : product['userRating']['rating'].toDouble()),
            userCanRate: product['userCanRate'],
            numberOfTimesProductRated:
                product['numberOfTimesProductRated'] == null
                    ? 0.0
                    : product['numberOfTimesProductRated'].toDouble(),
            userRated: product['userRated'],
            ratings: product['ratings'] == null
                ? 0.0
                : product['ratings'].toDouble()));
      });
      notifyListeners();
    } catch (err) {
      print('failed to get products $err');
      throw err;
    }
  }

  Future<void> updateProductRating(
      String productId,
      String ratingId,
      bool detailScreen,
      double ratings,
      double oldRatings,
      double numberOfTimesProductRated,
      double overAllRating) async {
    try {
      print('inside detail screen $productId');
      final productIndex =
          _searchProductList.indexWhere((prod) => prod.id == productId);
      if (productIndex != -1) {
        double productRate = ((overAllRating - oldRatings) + ratings) /
            (numberOfTimesProductRated);
        _searchProductList[productIndex].ratings = productRate;
        _searchProductList[productIndex].userRating.rating = ratings;
      }

      notifyListeners();

      final response = await http.patch(
        '$url/rating/$ratingId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode(
            {'userId': userId, 'productId': productId, 'rating': ratings}),
      );

      if (response.statusCode >= 400) {
        final productIndex =
            _searchProductList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          _searchProductList[productIndex].ratings = overAllRating;
          _searchProductList[productIndex].userRating.rating = oldRatings;
        }
      }
    } catch (err) {
      final productIndex =
          _searchProductList.indexWhere((prod) => prod.id == productId);
      if (productIndex != -1) {
        _searchProductList[productIndex].ratings = oldRatings;
        _searchProductList[productIndex].userRating.rating = oldRatings;
      }
    }
  }

  Future<void> addProductRating(
      String productId,
      bool detailScreen,
      double ratings,
      double oldRatings,
      double numberOfTimesProductRated,
      double overAllRating) async {
    try {
      final productIndex =
          _searchProductList.indexWhere((prod) => prod.id == productId);
      if (productIndex != -1) {
        _searchProductList[productIndex].ratings =
            (overAllRating + ratings) / (numberOfTimesProductRated + 1);
        _searchProductList[productIndex].userRating.rating = ratings;
        _searchProductList[productIndex].numberOfTimesProductRated =
            numberOfTimesProductRated + 1;
      }

      notifyListeners();

      final response = await http.post(
        '$url/rating',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode(
            {'userId': userId, 'productId': productId, 'rating': ratings}),
      );

      if (response.statusCode >= 400) {
        final productIndex =
            _searchProductList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          _searchProductList[productIndex].ratings = overAllRating;
          _searchProductList[productIndex].userRating.rating = oldRatings;
          _searchProductList[productIndex].numberOfTimesProductRated =
              numberOfTimesProductRated;
        }
      }
    } catch (err) {
      final productIndex =
          _searchProductList.indexWhere((prod) => prod.id == productId);
      if (productIndex != -1) {
        _searchProductList[productIndex].ratings = oldRatings;
        _searchProductList[productIndex].userRating.rating = oldRatings;
        _searchProductList[productIndex].numberOfTimesProductRated =
            numberOfTimesProductRated;
      }
    }
  }

  Future<void> toggleFavouriteItem(
      bool favouriteItem, String productId, bool detailScreen) async {
    final productIndex =
        _searchProductList.indexWhere((prod) => prod.id == productId);
    try {
      if (productIndex != -1) {
        _searchProductList[productIndex].favourite = favouriteItem;
      }

      notifyListeners();

      if (!favouriteItem == true) {
        final response = await http.delete('$url/favourite/$userId/$productId',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': authToken
            });
        if (response.statusCode >= 400) {
          Fluttertoast.showToast(
              msg: "Failed To favourite",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);

          if (productIndex != -1) {
            _searchProductList[productIndex].favourite = !favouriteItem;
          }
        }
      } else {
        final response = await http.post('$url/favourite',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': authToken
            },
            body: jsonEncode(
                <String, String>{'userId': userId, 'productId': productId}));

        if (response.statusCode >= 400) {
          Fluttertoast.showToast(
              msg: "Failed To favourite",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
          if (productIndex != -1) {
            _searchProductList[productIndex].favourite = !favouriteItem;
          }
        }
      }
    } catch (err) {
      print('faield to post favourite $err');
      Fluttertoast.showToast(
          msg: "Failed To favourite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);

      if (productIndex != -1) {
        _searchProductList[productIndex].favourite = !favouriteItem;
      }
    }
  }
}
