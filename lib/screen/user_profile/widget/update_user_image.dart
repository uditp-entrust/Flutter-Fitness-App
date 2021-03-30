import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';

class UpdateUserImage extends StatelessWidget {
  final double screenHeight;

  UpdateUserImage({this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (screenHeight * 0.38) - 70,
      alignment: Alignment.center,
      child: Stack(
        children: [
          CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/profile.jpg')),
          Positioned(
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              alignment: Alignment.center,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
                color: primaryColor(context),
              ),
            ),
            right: 5,
            bottom: 5,
          )
        ],
      ),
    );
  }
}
