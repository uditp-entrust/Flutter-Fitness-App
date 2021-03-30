import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        color: Theme.of(context).primaryColor,
      ),
      Container(
        height: getScreenHeight(context),
        width: getScreenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/fitness-app-logo.png')),
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: Column(
                children: [
                  Text(
                    'Hamstring',
                    style: splashScreenHeadingStyle,
                  ),
                  Text(
                    'The complete fitness solution',
                    style: splashScreenSubHeadingStyle,
                  )
                ],
              ),
            ),
            // )
          ],
        ),
      ),
    ]));
  }
}
