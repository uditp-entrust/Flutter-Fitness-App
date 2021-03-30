import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: primaryThemeColor,
      errorColor: errorThemeColor,
      colorScheme: ColorScheme.light(primary: primaryThemeColor));
}
