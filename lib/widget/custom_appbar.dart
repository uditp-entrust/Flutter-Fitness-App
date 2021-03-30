import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class CustomAppBar extends StatelessWidget {
  final IconData icon, rightOptionIcon;
  final String title, rightOptionLabel;
  final bool hasRightOption;
  final Function onIconTap, onRightIconTap;

  CustomAppBar(
      {this.icon,
      this.title,
      this.rightOptionIcon,
      this.rightOptionLabel,
      this.hasRightOption = false,
      this.onRightIconTap,
      this.onIconTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onIconTap,
                child: Icon(
                  Icons.arrow_back,
                  size: appbarIconSize,
                  color: Colors.black,
                ),
              ),
              if (hasRightOption)
                Row(
                  children: [
                    InkWell(
                      onTap: onRightIconTap,
                      child: Container(
                        margin: EdgeInsets.only(right: 3),
                        child: Text(
                          rightOptionLabel,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Icon(
                      rightOptionIcon,
                      size: 25,
                    )
                  ],
                )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: appbarHeadingStyle,
          ),
        ],
      ),
    );
  }
}
