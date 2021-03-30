import 'package:flutter/material.dart';
import 'package:hamstring_design/widget/custom_textfield.dart';

class LoginForm extends StatelessWidget {
  final bool isLoading;
  final Function onEmailSaved, onPasswordSaved;

  LoginForm({this.isLoading, this.onEmailSaved, this.onPasswordSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomTextField(
            hintText: "Email",
            textfieldIcon: Icon(Icons.email),
            enabled: !isLoading,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required field';
              }

              if (!value.contains('@')) {
                return 'Invalid email!';
              }
            },
            onSaved: onEmailSaved,
          ),
          CustomTextField(
            hintText: "Password",
            textfieldIcon: Icon(Icons.lock),
            enabled: !isLoading,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Required field';
              }
            },
            onSaved: onPasswordSaved,
          )
        ],
      ),
    );
  }
}
