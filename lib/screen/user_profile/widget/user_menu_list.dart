import 'package:flutter/material.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';
import 'package:hamstring_design/screen/auth/login_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_history_screen.dart';
import 'package:hamstring_design/screen/user_profile/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class UserMenuList extends StatelessWidget {
  final double screenHeight;
  final BuildContext userProfileContext;
  final Map<String, String> userDetails;

  UserMenuList({this.screenHeight, this.userProfileContext, this.userDetails});

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context);

    return Positioned(
      top: screenHeight * 0.2,
      left: (MediaQuery.of(userProfileContext).size.width / 2) -
          (MediaQuery.of(userProfileContext).size.width - 40) / 2,
      child: Container(
        height: screenHeight * 0.6,
        width: MediaQuery.of(userProfileContext).size.width - 40,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                child: Text(
                  '${userDetails['firstName']} ${userDetails['lastName']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(
                  '${userDetails['email']}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black54),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(color: Colors.black38),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName);
                    },
                    leading: Icon(Icons.edit),
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w700),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 17),
                  ),
                  ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Change Password',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 17),
                    onTap: () => {},
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(OrderHistoryScreen.routeName);
                      },
                      leading: Icon(Icons.assignment),
                      title: Text('My Orders',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 17)),
                  ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AddressListScreen.routeNameEdit);
                    },
                    leading: Icon(Icons.place),
                    title: Text('My Addresses',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await authUser.logout();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Theme.of(context).errorColor,
                          fontWeight: FontWeight.w700),
                    ),
                    leading: Icon(Icons.exit_to_app,
                        color: Theme.of(context).errorColor),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                      color: Theme.of(context).errorColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
