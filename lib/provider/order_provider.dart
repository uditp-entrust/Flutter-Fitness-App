import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/address.dart';
import 'package:hamstring_design/model/order.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  List<Order> _orderList = [];

  List<Order> get orderList {
    return [..._orderList];
  }

  Order _orderDetails = Order();

  Order get orderDetails {
    return _orderDetails;
  }

  Order _orderSummary = Order(
      userId: '',
      product: [],
      totalPrice: 0.0,
      address: '',
      paymentType: '',
      deliveryCharge: 0.0,
      userAddress: Address(
          userName: '', phoneNumber: '', houseNumber: '', addressType: 'home'));

  Order get orderSummary {
    return Order(
        userId: _orderSummary.userId,
        product: [..._orderSummary.product],
        totalPrice: _orderSummary.totalPrice,
        address: _orderSummary.address,
        paymentType: _orderSummary.paymentType,
        deliveryCharge: _orderSummary.deliveryCharge,
        userAddress: Address(
            userName: _orderSummary.userAddress.userName,
            phoneNumber: _orderSummary.userAddress.phoneNumber,
            houseNumber: _orderSummary.userAddress.houseNumber,
            addressType: _orderSummary.userAddress.addressType));
  }

  void addAddress() {
    _orderSummary.address = 'Chandkheda Ahmedabad';
  }

  void addUserAddress(Address address) {
    _orderSummary.userAddress.houseNumber = address.houseNumber;
    _orderSummary.userAddress.phoneNumber = address.phoneNumber;
    _orderSummary.userAddress.userId = address.userName;
    _orderSummary.userAddress.addressType = address.addressType;
  }

  void addPaymentType() {
    print(_orderSummary.userAddress.houseNumber);
    _orderSummary.paymentType = 'Cash on delivery';
  }

  final String authToken;
  final String userId;

  OrderProvider(this.authToken, this.userId);

  void selectAddress() {}

  Future<void> placeOrder(Order order) async {
    try {
      final response = await http.post(
        '$url/order',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode({
          'userId': userId,
          'product': [
            ...order.product.map((itemOrdered) => {
                  'productId': itemOrdered.productId,
                  'quantity': itemOrdered.quantity
                })
          ],
          'address': _orderSummary.userAddress.houseNumber,
          'paymentType': order.paymentType,
          'deliveryCharge': order.deliveryCharge,
          'totalAmount': order.totalPrice,
        }),
      );
    } catch (err) {
      print('failed to place order');
      throw err;
    }
  }

  Future<void> getOrderByUserId() async {
    try {
      final response = await http.get(
        '$url/order/user/$userId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      // print('order by userid ${json.decode(response.body)}');
      final responseData = json.decode(response.body);
      _orderList.clear();
      responseData.forEach((order) {
        _orderList.add(Order.fromJson(order));
      });
      // print('got orders $_orderList');
      // print('order by user id ${Order.fromJson(responseData)}');
      notifyListeners();
    } catch (err) {
      print('failed to get order $err');
      throw err;
    }
  }

  Future<void> getOrderById(String orderId) async {
    try {
      final response = await http.get(
        '$url/order/$orderId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = json.decode(response.body)[0];
      _orderDetails = Order.fromJson(responseData);
      notifyListeners();
      // print('current order details $responseData');
      // print('order by id value ${Order.fromJson(responseData)}');
    } catch (err) {
      print('failed to get order $err');
      throw err;
    }
  }
}
