import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String header;

  AuthHeader({this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 22, bottom: 6),
            child: Text(
              'Proceed with your',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )),
        Text(header,
            style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w900,
                color: Colors.black))
      ],
    );
  }
}
