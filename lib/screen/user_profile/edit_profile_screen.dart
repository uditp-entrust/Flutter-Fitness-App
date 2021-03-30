import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/http_expection.dart';
import 'package:hamstring_design/provider/user.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/screen/user_profile/widget/update_user_image.dart';
import 'package:hamstring_design/widget/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit_profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  Map<String, String> _userProfile = {
    'firstName': '',
    'lastName': '',
    'phoneNumber': '',
    'email': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      print('saving user profile');
      await Provider.of<User>(context, listen: false).updateUser(_userProfile);
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "User updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserProfileScreen()));
    } on HttpException catch (error) {
      if (error.toString().contains('This email address is already in use!')) {
        setState(() {
          _isLoading = false;
        });
        await showDialog(
            context: context,
            builder: (ctx) => CustomAlertDialog(
                title: 'Error!',
                message: 'This email address is already in use',
                label: 'Ok',
                submit: () {
                  Navigator.of(context).pop();
                }));
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Failed To User updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      print('failed to login ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context).userDetail;
    double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(UserProfileScreen.routeName);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                        height: screenHeight * 0.38,
                        color: primaryColor(context),
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                height: 20,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(
                                              UserProfileScreen.routeName),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    InkWell(
                                      onTap: _submit,
                                      child: Container(
                                        height: 18,
                                        width: 40,
                                        child: Text('SAVE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              UpdateUserImage(
                                screenHeight: screenHeight,
                              )
                            ],
                          ),
                        )),
                    Container(
                      height: screenHeight * 0.3,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                ),
                                initialValue: currentUser['firstName'] != null
                                    ? currentUser['firstName']
                                    : '',
                                enabled: !_isLoading,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Required field';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userProfile['firstName'] = value;
                                },
                              ),
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                  ),
                                  enabled: !_isLoading,
                                  initialValue: currentUser['lastName'] != null
                                      ? currentUser['lastName']
                                      : '',
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Required field';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (value) {
                                    _userProfile['lastName'] = value;
                                  }),
                            ),
                            // Container(
                            //   height: 50,
                            //   child: TextFormField(
                            //     style: TextStyle(
                            //         fontSize: 16.0,
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.black),
                            //     keyboardType: TextInputType.phone,
                            //     decoration: InputDecoration(
                            //       labelText: 'Phone Number',
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                enabled: false,
                                initialValue: currentUser['email'] != null
                                    ? currentUser['email']
                                    : '',
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Required field';
                                //   }

                                //   if (!value.contains('@')) {
                                //     return 'Invalid email!';
                                //   }
                                //   return null;
                                // },
                                onSaved: (value) {
                                  _userProfile['email'] = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
