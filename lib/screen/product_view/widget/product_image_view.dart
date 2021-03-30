import 'package:flutter/material.dart';
import 'package:hamstring_design/screen/product_view/widget/image_swipe.dart';
import 'package:hamstring_design/screen/product_view/widget/product_view_app_bar.dart';

class ProductImageView extends StatelessWidget {
  final double screenHeight, screenWidth;

  ProductImageView({this.screenHeight, this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      child: Column(
        children: [
          ProductViewAppbar(),
          Container(
            height: 250,
            child: ImageSwipe(
              screenWidth: screenWidth,
            ),
          ),
        ],
      ),
    );
  }
}
