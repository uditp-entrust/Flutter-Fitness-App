import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';

import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_item_details.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_item_price.dart';

class OrderItem extends StatelessWidget {
  final Cart order;
  final BuildContext orderContext;

  OrderItem({this.order, this.orderContext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(orderContext).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderItemDetails(
                order: order,
                orderContext: orderContext,
              ),
              OrderItemPrice(
                  itemPrice: double.parse(order.product.price) *
                      order.productCount.toInt()),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
