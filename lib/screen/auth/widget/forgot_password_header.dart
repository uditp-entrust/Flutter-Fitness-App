import 'package:flutter/material.dart';

class ForgotPasswordHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 22, bottom: 6),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            )),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
              'Please enter the email address associated with your account',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54)),
        )
      ],
    );
  }
}
