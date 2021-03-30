import 'package:flutter/material.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_summary_screen.dart';
import 'package:hamstring_design/widget/custom_button.dart';

class CartTotalAmount extends StatelessWidget {
  final double totalAmount;

  CartTotalAmount({this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54)),
                      Text('\$${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charges',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54)),
                      Text('\$30.00',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount',
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54)),
                      Text('\$${(totalAmount + 30).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700))
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomButton(
            onTap: () =>
                Navigator.of(context).pushNamed(AddressListScreen.routeName),
            label: 'Checkout',
          ),
        ],
      ),
    );
  }
}
