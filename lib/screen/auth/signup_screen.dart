import 'package:flutter/material.dart';
import 'package:hamstring_design/model/http_expection.dart';
import 'package:hamstring_design/model/user/user.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/screen/auth/login_screen.dart';

import 'package:hamstring_design/screen/auth/widget/app_logo.dart';
import 'package:hamstring_design/screen/auth/widget/auth_header.dart';
import 'package:hamstring_design/screen/auth/widget/login_text_link.dart';
import 'package:hamstring_design/screen/auth/widget/signup_form.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:hamstring_design/widget/custom_show_dialog.dart';
import 'package:hamstring_design/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
  String confirmPasswordValidate = '';
  User _authData = User();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).signupUser(_authData);
      await CustomShowDialog.customShowDialog(
          context,
          'Please confirm your email address',
          'Verification email has been sent. Pleach check your mailbox',
          'Back To Login', () {
        _formKey.currentState.reset();
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      });
    } on HttpException catch (e) {
      print('faled to signup user $e');
      await CustomShowDialog.customShowDialog(context, 'Failed To Register',
          'This email address is already in use', 'Try Again', () {
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      });
    } catch (error) {
      print('faled to signup user $error');
      await CustomShowDialog.customShowDialog(
          context,
          'Failed To Register',
          'Failed to register user due to some technical issue.',
          'Try Again', () {
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                AppLogo(
                  height: 100,
                  width: 100,
                ),
                AuthHeader(
                  header: 'Sign Up',
                ),
                SizedBox(
                  height: 16,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                              hintText: "First Name",
                              textfieldIcon: Icon(Icons.person),
                              enabled: !_isLoading,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required field';
                                }
                              },
                              onSaved: (value) {
                                _authData.firstName = value;
                              },
                            ),
                            CustomTextField(
                              hintText: "Last Name",
                              textfieldIcon: Icon(Icons.person),
                              enabled: !_isLoading,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required field';
                                }
                              },
                              onSaved: (value) {
                                _authData.lastName = value;
                              },
                            ),
                            CustomTextField(
                              hintText: "Email",
                              textfieldIcon: Icon(Icons.email),
                              enabled: !_isLoading,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required field';
                                }

                                if (!value.contains('@')) {
                                  return 'Invalid email!';
                                }
                              },
                              onSaved: (value) {
                                _authData.email = value;
                              },
                            ),
                            CustomTextField(
                              hintText: 'Phone Number',
                              textfieldIcon: Icon(Icons.phone_android),
                              enabled: !_isLoading,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Required field';
                                }
                                if (value.length != 10) {
                                  return 'Invalid phone number';
                                }
                              },
                              onSaved: (value) {
                                _authData.phoneNumber = value;
                              },
                            ),
                            CustomTextField(
                                hintText: "Password",
                                textfieldIcon: Icon(Icons.lock),
                                enabled: !_isLoading,
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Required field';
                                  }
                                  if (value.length < 5) {
                                    return 'Password is too short';
                                  }
                                },
                                onChanged: (text) {
                                  setState(() {
                                    confirmPasswordValidate = text;
                                  });
                                },
                                onSaved: (value) {
                                  _authData.password = value;
                                }),
                            CustomTextField(
                                hintText: "Confirm Password",
                                textfieldIcon: Icon(Icons.lock),
                                enabled: !_isLoading,
                                obscureText: true,
                                validator: (value) {
                                  if (value != confirmPasswordValidate) {
                                    return 'Password doesn\'t match';
                                  }
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      CustomButton(
                        label: "Signup",
                        onTap: _submit,
                      )
                    ],
                  ),
                ),
                LoginTextLink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
