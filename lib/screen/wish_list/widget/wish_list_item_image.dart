import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class WishListItemImage extends StatelessWidget {
  final String imageUrl;

  WishListItemImage({this.imageUrl});

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
        placeholder: placeholderLoadingImage,
        fit: BoxFit.fill,
        image: imageUrl,
      ),
    );
  }
}
