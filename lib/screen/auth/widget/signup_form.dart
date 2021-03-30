import 'package:flutter/material.dart';

import 'package:hamstring_design/widget/custom_textfield.dart';

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            hintText: "First Name",
            textfieldIcon: Icon(Icons.person),
          ),
          CustomTextField(
            hintText: "Last Name",
            textfieldIcon: Icon(Icons.person),
          ),
          CustomTextField(
            hintText: "Email",
            textfieldIcon: Icon(Icons.email),
          ),
          CustomTextField(
            hintText: "Password",
            textfieldIcon: Icon(Icons.create),
          ),
          CustomTextField(
            hintText: "Confirm Password",
            textfieldIcon: Icon(Icons.create),
          )
        ],
      ),
    );
  }
}
