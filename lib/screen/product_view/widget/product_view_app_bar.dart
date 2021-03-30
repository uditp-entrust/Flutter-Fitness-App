import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';

class ProductViewAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 40,
    //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       InkWell(
    //         onTap: () {
    //           Navigator.of(context).pushNamed(ProductDashboardScreen.routeName);
    //         },
    //         child: Icon(
    //           Icons.arrow_back_ios,
    //         ),
    //       ),
    //       // Icon(Icons.shopping_bag_outlined)
    //     ],
    //   ),
    // );
    return Container(
      height: 120,
      child: Container(
        margin: EdgeInsets.all(screenMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductDashboardScreen.routeName);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: appbarIconSize,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'Profile',
            //   style: TextStyle(
            //       fontSize: 26,
            //       fontWeight: FontWeight.w800,
            //       color: Colors.white),
            // ),
          ],
        ),
      ),
    );
  }
}
