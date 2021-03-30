import 'package:flutter/material.dart';
import 'package:hamstring_design/model/http_expection.dart';
import 'package:hamstring_design/model/user/user.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/screen/auth/forgot_password_screen.dart';

import 'package:hamstring_design/screen/auth/widget/app_logo.dart';
import 'package:hamstring_design/screen/auth/widget/auth_header.dart';
import 'package:hamstring_design/screen/auth/widget/login_form.dart';
import 'package:hamstring_design/screen/auth/widget/signup_text_link.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:hamstring_design/widget/custom_show_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _isLoading = false;
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
      await Provider.of<Auth>(context, listen: false)
          .loginUser(_authData.email, _authData.password);
      Navigator.of(context)
          .pushReplacementNamed(ProductDashboardScreen.routeName);
    } on HttpException catch (error) {
      print('validation err $error');
      var errMessage = 'Authentication failed';
      var label = 'Try again';
      var title = 'Authentication failed!';
      if (error.toString().contains('Incorrect email!')) {
        errMessage = 'Invalid email';
      }
      if (error.toString().contains('Incorrect password!')) {
        errMessage = 'Invalid password';
      }
      if (error.toString().contains('User not verified')) {
        title = 'Please confirm your email address';
        errMessage =
            'User email confirmation is pending. Check your email inbox and confirm your email address';
        label = 'Back To Login';
      }
      await CustomShowDialog.customShowDialog(context, title, errMessage, label,
          () {
        _formKey.currentState.reset();
        Navigator.of(context).pop();
      });
    } catch (error) {
      print('faled to login $error');
      await CustomShowDialog.customShowDialog(
          context,
          "Failed to login",
          'Failed to register user due to some technical issue.',
          'Try again', () {
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
      onWillPop: () async => false,
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
                AuthHeader(header: 'Log In'),
                SizedBox(
                  height: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginForm(
                        onEmailSaved: (value) {
                          _authData.email = value;
                        },
                        onPasswordSaved: (value) {
                          _authData.password = value;
                        },
                        isLoading: _isLoading,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                        label: "Login",
                        onTap: _submit,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ForgotPasswordScreen.routeName),
                        child: Text('Forgot Password',
                            style: TextStyle(color: Colors.black54)),
                      )
                    ],
                  ),
                ),
                SignupTextLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
