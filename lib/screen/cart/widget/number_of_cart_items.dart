import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/screen/cart/widget/cart_update_icon.dart';

class NumberOfCartItems extends StatelessWidget {
  final double width;
  final int itemQuantity;
  final Cart cartItem;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;

  NumberOfCartItems(
      {this.width,
      this.itemQuantity,
      this.addItem,
      this.removeItem,
      this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CartUpdateIcon(
            icon: Icons.remove,
            isRemove: true,
            removeItem: removeItem,
            cartItem: cartItem,
          ),
          Text(
            '$itemQuantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          CartUpdateIcon(
            icon: Icons.add,
            isRemove: false,
            addItem: addItem,
            cartItem: cartItem,
          )
        ],
      ),
    );
  }
}
