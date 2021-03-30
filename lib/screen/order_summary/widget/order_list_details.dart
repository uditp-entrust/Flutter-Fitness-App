import 'package:flutter/material.dart';
import 'package:hamstring_design/model/order.dart';
import 'package:hamstring_design/model/product_details.dart';
import 'package:hamstring_design/screen/order_summary/order_status_screen.dart';

import 'package:hamstring_design/screen/order_summary/widget/date_of_order_placed.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_id.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_information.dart';

class OrderListDetails extends StatelessWidget {
  final Order orderDetails;

  int totalItems(productList) {
    double numberOfItmes = 0.0;
    productList.forEach((ProductDetails productDetails) {
      numberOfItmes += productDetails.quantity;
    });

    return numberOfItmes.toInt();
  }

  OrderListDetails({this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderStatusScreen(
                    orderId: orderDetails.id,
                    totalAmount: orderDetails.totalPrice,
                    orderPlacedDate: orderDetails.createdAt,
                    totalItems: totalItems(orderDetails.product))));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xFFF2F3F4),
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Container(
          height: 90,
          margin: EdgeInsets.all(10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OrderId(orderId: orderDetails.id),
                DateOfOrderPlaced(orderPlacedDate: orderDetails.createdAt),
                OrderInformation(
                    totalItems: totalItems(orderDetails.product),
                    totalPrice: orderDetails.totalPrice + 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
