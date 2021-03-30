import 'package:flutter/material.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/product_view/widget/product_cart_update_icon.dart';

class ProductPrice extends StatelessWidget {
  final Product product;

  ProductPrice({
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Container(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductCartUpdateIcon(
                  icon: Icons.add,
                ),
                Container(
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                ProductCartUpdateIcon(
                  icon: Icons.remove,
                ),
              ],
            ),
          ),
          Text('\$${product.price}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))
        ],
      ),
    );
  }
}
