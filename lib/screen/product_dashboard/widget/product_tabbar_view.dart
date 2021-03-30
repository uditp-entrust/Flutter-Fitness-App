import 'package:flutter/material.dart';

import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/product_dashboard/product_tabs/accessories.dart';
import 'package:hamstring_design/screen/product_dashboard/product_tabs/clothing.dart';
import 'package:hamstring_design/screen/product_dashboard/product_tabs/exercise_and_fitness.dart';
import 'package:hamstring_design/screen/product_dashboard/product_tabs/footwear.dart';

class ProductTabBarView extends StatelessWidget {
  final List<Product> productList;
  final Function addToCart;
  final double imageTopMargin, imageLeftMargin, imageWidth, imageHeight;
  final Future<void> Function(bool, String, bool) toggleFavouriteItem;

  ProductTabBarView(
      {this.productList,
      this.imageTopMargin,
      this.imageLeftMargin,
      this.imageHeight,
      this.imageWidth,
      this.addToCart,
      this.toggleFavouriteItem});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ExerciseAndFitness(
            productList: productList,
            imageHeight: imageHeight,
            imageTopMargin: imageTopMargin,
            imageLeftMargin: imageLeftMargin,
            imageWidth: imageWidth,
            addToCart: addToCart,
            toggleFavouriteItem: toggleFavouriteItem),
        Accessories(),
        Clothing(),
        Footwear()
      ],
    );
  }
}
