import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/cart/widget/cart_item_details.dart';
import 'package:hamstring_design/screen/cart/widget/cart_item_image.dart';

class CartItem extends StatelessWidget {
  final Cart cartItem;
  final BuildContext cartBuildContext;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;

  CartItem(
      {this.cartItem, this.cartBuildContext, this.removeItem, this.addItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.id),
      onDismissed: (direction) {
        double itemPrice = cartItem.product.price == null
            ? 0.0
            : double.parse(cartItem.product.price);
        removeItem(cartItem.productCount, cartItem.id, itemPrice, true);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.only(right: 40),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF2F3F4),
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Container(
          height: 80,
          margin: EdgeInsets.all(16),
          child: Row(
            children: [
              CartItemImage(
                imageUrl: cartItem.product.productImages[0],
              ),
              CartItemDetails(
                  cartBuildContext: cartBuildContext,
                  cartItem: cartItem,
                  removeItem: removeItem,
                  addItem: addItem),
            ],
          ),
        ),
      ),
    );
  }
}
