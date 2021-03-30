import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/provider/user.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/user_profile/widget/user_image.dart';
import 'package:hamstring_design/screen/user_profile/widget/user_menu_list.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user_profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<User>(context).getUserById().then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context);
    Map<String, String> userData = Provider.of<User>(context).userDetail;

    double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(ProductDashboardScreen.routeName);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Column(children: [
                  Container(
                    height: screenHeight * 0.3,
                    color: primaryColor(context),
                  ),
                  Container(
                    height: screenHeight * 0.7,
                  ),
                ]),
                // Container(
                //   margin: EdgeInsets.only(left: 10, top: screenHeight * 0.1),
                //   child: Text(
                //     'Profile',
                //     style: TextStyle(
                //         fontSize: 24,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w800),
                //   ),
                // ),
                Container(
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
                                Navigator.of(context).pushNamed(
                                    ProductDashboardScreen.routeName);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: appbarIconSize,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    UserMenuList(
                        screenHeight: screenHeight,
                        userProfileContext: context,
                        userDetails: userData),
                    UserImage(
                      screenHeight: screenHeight,
                      userProfileContext: context,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
