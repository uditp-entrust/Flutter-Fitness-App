import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/model/user_rating.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  List<Product> _productList = [];
  Product _productDetails = Product(
      id: '',
      name: '',
      model: '',
      description: '',
      price: '',
      company: '',
      productImages: [],
      ratings: 0.0,
      numberOfTimesProductRated: 0.0,
      userRating:
          UserRating(userId: '', productId: '', rating: 0.0, review: ''),
      cart: Cart(),
      favourite: false,
      addedToCart: false,
      userCanRate: false,
      userRated: false);

  List<Product> get productList {
    return [..._productList];
  }

  Product get productDetails {
    return Product(
        id: _productDetails.id,
        name: _productDetails.name,
        model: _productDetails.model,
        description: _productDetails.description,
        price: _productDetails.price,
        company: _productDetails.company,
        productImages: _productDetails.productImages,
        ratings: _productDetails.ratings,
        userRating: UserRating(
            id: _productDetails.userRating.id,
            userId: _productDetails.userRating.userId,
            productId: _productDetails.userRating.productId,
            review: _productDetails.userRating.review,
            rating: _productDetails.userRating.rating),
        favourite: _productDetails.favourite,
        addedToCart: _productDetails.addedToCart,
        userCanRate: _productDetails.userCanRate,
        userRated: _productDetails.userRated,
        numberOfTimesProductRated: _productDetails.numberOfTimesProductRated);
  }

  final String authToken;
  final String userId;

  ProductProvider(this.authToken, this.userId);

  Future<void> updateProductRating(
      String productId,
      String ratingId,
      bool detailScreen,
      double ratings,
      double oldRatings,
      double numberOfTimesProductRated,
      double overAllRating) async {
    try {
      if (!detailScreen) {
        print('inside detail screen $productId');
        final productIndex =
            _productList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          double productRate = ((overAllRating - oldRatings) + ratings) /
              (numberOfTimesProductRated);
          _productList[productIndex].ratings = productRate;
          _productList[productIndex].userRating.rating = ratings;
        }
      } else {
        _productDetails.ratings = ((overAllRating - oldRatings) + ratings) /
            (numberOfTimesProductRated);
        _productDetails.userRating.rating = ratings;
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
        if (!detailScreen) {
          final productIndex =
              _productList.indexWhere((prod) => prod.id == productId);
          if (productIndex != -1) {
            _productList[productIndex].ratings = overAllRating;
            _productList[productIndex].userRating.rating = oldRatings;
          }
        } else {
          _productDetails.ratings = overAllRating;
          _productDetails.userRating.rating = oldRatings;
        }
      }
    } catch (err) {
      if (!detailScreen) {
        final productIndex =
            _productList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          _productList[productIndex].ratings = oldRatings;
          _productList[productIndex].userRating.rating = oldRatings;
        }
      } else {
        _productDetails.ratings = oldRatings;
        _productDetails.userRating.rating = oldRatings;
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
      if (!detailScreen) {
        final productIndex =
            _productList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          _productList[productIndex].ratings =
              (overAllRating + ratings) / (numberOfTimesProductRated + 1);
          _productList[productIndex].userRating.rating = ratings;
          _productList[productIndex].numberOfTimesProductRated =
              numberOfTimesProductRated + 1;
        }
      } else {
        _productDetails.ratings =
            (overAllRating + ratings) / (numberOfTimesProductRated + 1);
        _productDetails.numberOfTimesProductRated =
            numberOfTimesProductRated + 1;
        _productDetails.userRating.rating = ratings;
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
        if (!detailScreen) {
          final productIndex =
              _productList.indexWhere((prod) => prod.id == productId);
          if (productIndex != -1) {
            _productList[productIndex].ratings = overAllRating;
            _productList[productIndex].userRating.rating = oldRatings;
            _productList[productIndex].numberOfTimesProductRated =
                numberOfTimesProductRated;
          }
        } else {
          _productDetails.ratings = overAllRating;
          _productDetails.numberOfTimesProductRated = numberOfTimesProductRated;
          _productDetails.userRating.rating = oldRatings;
        }
      }
    } catch (err) {
      if (!detailScreen) {
        final productIndex =
            _productList.indexWhere((prod) => prod.id == productId);
        if (productIndex != -1) {
          _productList[productIndex].ratings = oldRatings;
          _productList[productIndex].userRating.rating = oldRatings;
          _productList[productIndex].numberOfTimesProductRated =
              numberOfTimesProductRated;
        }
      } else {
        _productDetails.ratings = oldRatings;
        _productDetails.numberOfTimesProductRated = numberOfTimesProductRated;
        _productDetails.userRating.rating = oldRatings;
      }
    }
  }

  Future<void> toggleFavouriteItem(
      bool favouriteItem, String productId, bool detailScreen) async {
    final productIndex =
        _productList.indexWhere((prod) => prod.id == productId);
    try {
      if (detailScreen) {
        _productDetails.favourite = favouriteItem;
      } else {
        if (productIndex != -1) {
          _productList[productIndex].favourite = favouriteItem;
        }
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
          if (detailScreen) {
            _productDetails.favourite = favouriteItem;
          } else {
            if (productIndex != -1) {
              _productList[productIndex].favourite = !favouriteItem;
            }
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
          if (detailScreen) {
            _productDetails.favourite = favouriteItem;
          } else {
            if (productIndex != -1) {
              _productList[productIndex].favourite = !favouriteItem;
            }
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

      if (detailScreen) {
        _productDetails.favourite = favouriteItem;
      } else {
        if (productIndex != -1) {
          _productList[productIndex].favourite = !favouriteItem;
        }
      }
    }
  }

  Future<void> getProduct(String productId) async {
    try {
      final response = await http.get(
        '$url/product/$userId/$productId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      if (responseData == null) {
        return;
      }
      _productDetails.id = responseData[0]['_id'];
      _productDetails.name = responseData[0]['name'];
      _productDetails.model = responseData[0]['model'];
      _productDetails.price = responseData[0]['price'];
      _productDetails.description = responseData[0]['description'];
      _productDetails.company = responseData[0]['company'];
      _productDetails.productImages = responseData[0]['productImages'] == null
          ? []
          : [...responseData[0]['productImages']];
      _productDetails.favourite = responseData[0]['favourite'];
      _productDetails.cart = responseData[0]['userRating'] == null
          ? Cart()
          : Cart(
              id: responseData[0]['cart']['_id'],
              productCount: responseData[0]['cart']['productCount']);
      _productDetails.userRating = responseData[0]['userRating'] == null
          ? UserRating(userId: '', productId: '', rating: 0.0, review: '')
          : UserRating(
              id: responseData[0]['userRating']['_id'],
              userId: responseData[0]['userRating']['userId'],
              productId: responseData[0]['userRating']['productId'],
              review: responseData[0]['userRating']['review'],
              rating: responseData[0]['userRating']['rating'] == null
                  ? 0.0
                  : responseData[0]['userRating']['rating'].toDouble());
      _productDetails.userCanRate = responseData[0]['userCanRate'];
      _productDetails.userRated = responseData[0]['userRated'];
      _productDetails.addedToCart = responseData[0]['addedToCart'];
      _productDetails.numberOfTimesProductRated =
          responseData[0]['numberOfTimesProductRated'] == null
              ? 0.0
              : responseData[0]['numberOfTimesProductRated'].toDouble();
      _productDetails.ratings = responseData[0]['ratings'] == null
          ? 0.0
          : responseData[0]['ratings'].toDouble();

      notifyListeners();
    } catch (err) {
      print('failed to get product $err');
    }
  }

  Future<void> getAllProducts(String searchString) async {
    print('get all products function called');
    try {
      var response;
      if (searchString == "") {
        response = await http.get(
          '$url/product/user/$userId',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          },
        );
      } else {
        response = await http.get(
          '$url/product/search/$userId/$searchString',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': authToken
          },
        );
      }
      final responseData = jsonDecode(response.body);

      print('product lsit response $responseData');
      if (responseData == null) {
        return;
      }
      _productList.clear();
      responseData.forEach((product) {
        _productList.add(Product(
            id: product['_id'],
            name: product['name'],
            // model: product['model'],
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
}
