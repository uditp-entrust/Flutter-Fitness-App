import 'package:flutter/material.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/screen/cart/widget/number_of_cart_items.dart';

class CartItemDetails extends StatelessWidget {
  final Cart cartItem;
  final BuildContext cartBuildContext;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;

  CartItemDetails(
      {this.cartItem, this.cartBuildContext, this.addItem, this.removeItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(cartBuildContext).size.width * 0.6,
                  child: Text(
                    '${cartItem.product.name}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    // '\$${cartItem.product.price} * ${cartItem.productCount.toInt()} = \$${cartItem.totalPrice}',
                    '\$${cartItem.totalPrice}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  )),
            ],
          ),
          Container(
            width: MediaQuery.of(cartBuildContext).size.width - 80 - 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${cartItem.product.company}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45)),
                NumberOfCartItems(
                    itemQuantity: cartItem.productCount.toInt(),
                    cartItem: cartItem,
                    width: MediaQuery.of(cartBuildContext).size.width * 0.22,
                    removeItem: removeItem,
                    addItem: addItem)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
