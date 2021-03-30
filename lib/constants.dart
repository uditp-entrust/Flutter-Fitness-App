import 'dart:math';

import 'package:flutter/material.dart';

final splashScreenHeadingStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

final splashScreenSubHeadingStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

final customTextFieldStyle =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

final appbarHeadingStyle = TextStyle(fontSize: 26, fontWeight: FontWeight.w800);

final customButtonStyle =
    TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500);

final regularDarkText =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);

final orderConfirmationMessageStyle =
    TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400);

double getScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double getScreenWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

double getStatusBarHeight(BuildContext context) =>
    MediaQuery.of(context).padding.top;

Color primaryColor(BuildContext context) => Theme.of(context).primaryColor;

Color randomColor() =>
    Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(0.4);

final List<String> productCategoriesList = [
  'Exercise & Fitness',
  'Accessories',
  'Clothing',
  'Footwear'
];

final appbarIconSize = 30.0;

final placeholderLoadingImage = 'assets/images/loading.gif';

final screenMargin = 16.0;

final errorThemeColor = Color(0xFFE20D31);

final primaryThemeColor = Color(0xFFE20D31);

const API_URL = "http://10.0.2.2:3001";
