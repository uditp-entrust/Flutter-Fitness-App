import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class OrderItemPrice extends StatelessWidget {
  final double itemPrice;

  OrderItemPrice({this.itemPrice});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${itemPrice.toStringAsFixed(2)}',
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: primaryColor(context)),
    );
  }
}
