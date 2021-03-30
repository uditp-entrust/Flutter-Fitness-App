import 'package:flutter/material.dart';

import 'package:hamstring_design/model/wish__list.dart';
import 'package:hamstring_design/screen/wish_list/widget/wish_list_item_details.dart';
import 'package:hamstring_design/screen/wish_list/widget/wish_list_item_image.dart';

class WishListItem extends StatelessWidget {
  final WishList cartItem;
  final BuildContext wishListContext;
  final Future<void> Function(String) removeFavouriteItem;

  WishListItem({this.cartItem, this.wishListContext, this.removeFavouriteItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeFavouriteItem(cartItem.product.id);
      },
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
              WishListItemImage(
                imageUrl: cartItem.product.productImages[0],
              ),
              WishListItemDetails(
                  cartItem: cartItem, wishListContext: wishListContext)
            ],
          ),
        ),
      ),
    );
  }
}
