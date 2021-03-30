import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class OrderInformation extends StatelessWidget {
  final int totalItems;
  final double totalPrice;

  OrderInformation({this.totalItems, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$totalItems Items',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          Text('\$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 20,
                  color: primaryColor(context),
                  fontWeight: FontWeight.w800))
        ],
      ),
    );
  }
}
