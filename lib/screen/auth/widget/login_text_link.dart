import 'package:flutter/material.dart';

import 'package:hamstring_design/screen/auth/login_screen.dart';

class LoginTextLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have account? ',
              style: TextStyle(color: Colors.black54)),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
            child: Text(
              'Log In',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
}
