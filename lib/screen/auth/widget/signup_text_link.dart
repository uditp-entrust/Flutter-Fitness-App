import 'package:flutter/material.dart';

import 'package:hamstring_design/screen/auth/signup_screen.dart';

class SignupTextLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don\'t have account? ',
              style: TextStyle(color: Colors.black54)),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(SignupScreen.routeName),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
