import 'package:flutter/material.dart';

import 'package:hamstring_design/widget/custom_alert_dialog.dart';

class CustomShowDialog {
  static Future<void> customShowDialog(BuildContext context, String title,
      String message, String label, Function submit) async {
    await showDialog(
        context: context,
        builder: (ctx) => CustomAlertDialog(
            title: title, message: message, label: label, submit: submit));
  }
}
