import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/product_view/widget/product_price.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  final double screenWidth;
  final Future<void> Function(double, String, double) addItem;
  final Future<void> Function(double, String, double, bool) removeItem;

  ProductDescription({
    this.screenWidth,
    this.product,
    this.removeItem,
    this.addItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${product.name}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text('${product.company}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: primaryColor(context)))),
        Container(
            width: screenWidth - 32,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text('${product.description}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  height: 1.5,
                ))),
        ProductPrice(
          product: product,
        ),
      ],
    );
  }
}
