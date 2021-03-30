import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/cart/widget/cart_item.dart';
import 'package:hamstring_design/screen/cart/widget/cart_total_amount.dart';
import 'package:hamstring_design/screen/product_view/product_view_screen.dart';

class CartList extends StatelessWidget {
  final List<Cart> cartList;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;
  final double totalAmount;

  CartList({this.cartList, this.removeItem, this.addItem, this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView(
            children: [
              ...cartList
                  .map((cartItem) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductViewScreen(cartItem.product.id))),
                        child: CartItem(
                            cartBuildContext: context,
                            cartItem: cartItem,
                            removeItem: removeItem,
                            addItem: addItem),
                      ))
                  .toList(),
            ],
          ),
        ),
        CartTotalAmount(totalAmount: totalAmount)
      ],
    ));
  }
}
