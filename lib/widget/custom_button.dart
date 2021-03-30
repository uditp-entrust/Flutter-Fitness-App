import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onTap;

  CustomButton({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: primaryColor(context),
            borderRadius: BorderRadius.circular(3)),
        alignment: Alignment.center,
        child: Text(label.toUpperCase(), style: customButtonStyle),
      ),
    );
  }
}
