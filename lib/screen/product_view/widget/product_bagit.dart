import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class ProductBagIt extends StatelessWidget {
  final double screenWidth;
  final Function addToCart;
  final String label, productId, productPrice;
  final bool favorite, addedToCart;
  final Future<void> Function(bool, String, bool) toggleFavouriteItem;

  ProductBagIt(
      {this.screenWidth,
      this.addToCart,
      this.label,
      this.toggleFavouriteItem,
      this.productId,
      this.favorite,
      this.productPrice,
      this.addedToCart});

  @override
  Widget build(BuildContext context) {
    IconData favoriteIcon =
        favorite == true ? Icons.favorite : Icons.favorite_border;

    return Row(
      children: [
        InkWell(
          onTap: () => toggleFavouriteItem(!favorite, productId, true),
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor(context)),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              favoriteIcon,
              size: 30,
              color: primaryColor(context),
            ),
            alignment: Alignment.center,
          ),
        ),
        InkWell(
          onTap: () async {
            await addToCart(addedToCart, productId, productPrice);
          },
          child: Container(
            height: 55,
            width: screenWidth - 32 - 55 - 10,
            decoration: BoxDecoration(
                color: primaryColor(context),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 0.4),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
