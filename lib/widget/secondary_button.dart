import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final Function onTap;

  SecondaryButton({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(3)),
        alignment: Alignment.center,
        child: Text(label.toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: primaryColor(context),
                fontWeight: FontWeight.w800)),
      ),
    );
  }
}
