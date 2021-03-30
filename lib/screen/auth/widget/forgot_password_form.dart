import 'package:flutter/material.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:hamstring_design/widget/custom_textfield.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextField(
                hintText: "Email",
                textfieldIcon: Icon(Icons.email),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        CustomButton(
          label: "Send Reset Password Link",
        )
      ],
    );
  }
}
