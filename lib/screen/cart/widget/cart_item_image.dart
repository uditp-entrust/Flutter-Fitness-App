import 'package:flutter/material.dart';

class CartItemImage extends StatelessWidget {
  final String imageUrl;

  CartItemImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      margin: EdgeInsets.only(right: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        fit: BoxFit.fill,
        image: imageUrl,
      ),
    );
  }
}
