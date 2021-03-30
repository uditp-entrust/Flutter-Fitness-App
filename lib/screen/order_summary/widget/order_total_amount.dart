import 'package:flutter/material.dart';

class OrderTotalAmount extends StatelessWidget {
  final double totalAmount;

  OrderTotalAmount({this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              Text('\$${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600)),
              Text('\$30.00',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              Text('\$${(totalAmount + 30).toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      letterSpacing: 0.7))
            ],
          ),
        ),
      ],
    );
  }
}
