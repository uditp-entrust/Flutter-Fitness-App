import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';

class CartUpdateIcon extends StatelessWidget {
  final IconData icon;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;
  final bool isRemove;
  final Cart cartItem;

  CartUpdateIcon(
      {this.icon, this.addItem, this.removeItem, this.cartItem, this.isRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        double itemPrice = cartItem.product.price == null
            ? 0.0
            : double.parse(cartItem.product.price);
        if (isRemove) {
          removeItem(cartItem.productCount, cartItem.id, itemPrice, false);
        } else {
          addItem(cartItem.productCount, cartItem.id, itemPrice);
        }
      },
      child: Container(
        height: 25,
        width: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          size: 20,
        ),
      ),
    );
  }
}
