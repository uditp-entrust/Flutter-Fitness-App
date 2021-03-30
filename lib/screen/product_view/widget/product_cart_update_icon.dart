import 'package:flutter/material.dart';

class ProductCartUpdateIcon extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  ProductCartUpdateIcon({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 26,
        width: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(50)),
        child: Icon(icon),
      ),
    );
  }
}
