import 'package:flutter/material.dart';

import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/product_view/widget/product_bagit.dart';
import 'package:hamstring_design/screen/product_view/widget/product_description.dart';

class ProductDetails extends StatelessWidget {
  final double screenHeight, screenWidth;
  final Product product;
  final Function addToCart;
  final String label;
  final Future<void> Function(bool, String, bool) toggleFavouriteItem;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;

  ProductDetails({
    this.product,
    this.screenHeight,
    this.screenWidth,
    this.addToCart,
    this.label,
    this.toggleFavouriteItem,
    this.removeItem,
    this.addItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.5,
      margin: EdgeInsets.only(top: screenHeight * 0.5),
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 34, 16, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductDescription(
                product: product,
                screenWidth: screenWidth,
                addItem: addItem,
                removeItem: removeItem),
            ProductBagIt(
                screenWidth: screenWidth,
                addToCart: addToCart,
                productId: product.id,
                addedToCart: product.addedToCart,
                favorite: product.favourite,
                label: label,
                toggleFavouriteItem: toggleFavouriteItem,
                productPrice: product.price)
          ],
        ),
      ),
    );
  }
}
