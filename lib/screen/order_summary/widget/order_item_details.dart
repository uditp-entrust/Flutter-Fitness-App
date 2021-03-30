import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';

class OrderItemDetails extends StatelessWidget {
  final Cart order;
  final BuildContext orderContext;

  OrderItemDetails({this.order, this.orderContext});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(4)),
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${order.productCount.toInt()}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ))),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 9),
          child: Icon(
            Icons.clear,
            size: 14,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(orderContext).size.width * 0.55,
                child: Text(
                  order.product.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                )),
            Text(
              'Price: ${order.product.price}',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ],
    );
  }
}
