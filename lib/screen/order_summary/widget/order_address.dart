import 'package:flutter/material.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';

class OrderAddress extends StatelessWidget {
  final String userAddress;

  OrderAddress({this.userAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text('Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text('$userAddress',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
            InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(AddressListScreen.routeName),
              child: Text('Change',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFE20D31),
                      fontWeight: FontWeight.w600)),
            )
          ],
        )
      ],
    );
  }
}
