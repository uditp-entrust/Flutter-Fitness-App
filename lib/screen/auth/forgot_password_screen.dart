import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hamstring_design/model/http_expection.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/screen/auth/login_screen.dart';
import 'package:hamstring_design/screen/auth/widget/app_logo.dart';
import 'package:hamstring_design/screen/auth/widget/forgot_password_header.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:hamstring_design/widget/custom_show_dialog.dart';
import 'package:hamstring_design/widget/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/forgot_password";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  String userEmail = "";

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).resetPassword(userEmail);
      await CustomShowDialog.customShowDialog(
          context,
          'Reset Password Link Sent',
          'Please check your email',
          'Back To Login', () {
        _formKey.currentState.reset();
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      });
    } on HttpException catch (error) {
      var errMessage = '';
      var label = 'Try Again';
      var title = '';
      if (error.toString().contains('User does not exists')) {
        title = 'User does not exists';
        errMessage = 'Try with valid email address';
      }
      if (error.toString().contains('User verification is pending')) {
        title = 'Please confirm your email address';
        errMessage =
            'User email confirmation is pending. Check your email inbox and confirm your email address';
        label = 'Back';
      }
      await CustomShowDialog.customShowDialog(context, title, errMessage, label,
          () {
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      });
    } catch (error) {
      print('failed to reset password $error');
      await CustomShowDialog.customShowDialog(
          context,
          'Failed to send email',
          'Failed to send email due to some technical issue. Please try again',
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
                  height: 65,
                ),
                AppLogo(
                  height: 100,
                  width: 100,
                ),
                ForgotPasswordHeader(),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                                userEmail = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        label: "Send Reset Password Link",
                        onTap: _submit,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(LoginScreen.routeName),
                    child: Text(
                      'Back To Login',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
