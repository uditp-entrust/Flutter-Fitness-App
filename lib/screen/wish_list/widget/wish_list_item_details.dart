import 'package:flutter/material.dart';

import 'package:hamstring_design/model/wish__list.dart';

class WishListItemDetails extends StatelessWidget {
  final WishList cartItem;
  final BuildContext wishListContext;

  WishListItemDetails({this.cartItem, this.wishListContext});

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
                  width: MediaQuery.of(wishListContext).size.width * 0.6,
                  child: Text(
                    '${cartItem.product.name}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    '\$${cartItem.product.price}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54),
                  )),
            ],
          ),
          Container(
            width: MediaQuery.of(wishListContext).size.width - 80 - 48,
            child: Text('${cartItem.product.company}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45)),
          ),
        ],
      ),
    );
  }
}
