import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_address.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_item.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_payment_type.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_total_amount.dart';
import 'package:hamstring_design/widget/custom_button.dart';

class OrderDetails extends StatelessWidget {
  final List<Cart> orderList;
  final BuildContext orderContext;
  final double totalAmount;
  final Future<void> Function() orderConfirm;
  final String userAddress;
  // final Future<void> Function(double, String, double) removeItem, addItem;

  OrderDetails(
      {this.orderList,
      this.orderContext,
      this.totalAmount,
      this.orderConfirm,
      this.userAddress});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(screenMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      ...orderList
                          .map((order) => OrderItem(
                                order: order,
                                orderContext: orderContext,
                              ))
                          .toList(),
                    ],
                  ),
                ),
                OrderTotalAmount(totalAmount: totalAmount),
                OrderAddress(userAddress: userAddress),
                OrderPaymentType(),
              ],
            ),
            // CustomButton(
            //   onTap: orderConfirm,
            //   label: 'Place Order',
            // ),
          ],
        ),
      ),
    );
  }
}
