import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double screenHeight;
  final BuildContext userProfileContext;

  UserImage({this.screenHeight, this.userProfileContext});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.12,
      left: (MediaQuery.of(userProfileContext).size.width / 2) - 65,
      child: Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2.5),
            borderRadius: BorderRadius.circular(100)),
        child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.jpg')),
      ),
    );
  }
}
