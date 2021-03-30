import 'package:flutter/material.dart';

class OrderId extends StatelessWidget {
  final String orderId;

  OrderId({this.orderId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Order#:',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
        ),
        Container(
          margin: EdgeInsets.only(left: 3),
          child: Text(
            // '604f3e0ceef78a2d70043b47',
            '$orderId',
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
