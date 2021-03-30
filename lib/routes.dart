import 'package:flutter/widgets.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';

import 'package:hamstring_design/screen/auth/forgot_password_screen.dart';
import 'package:hamstring_design/screen/auth/login_screen.dart';
import 'package:hamstring_design/screen/cart/cart_screen.dart';
import 'package:hamstring_design/screen/auth/signup_screen.dart';
import 'package:hamstring_design/screen/cycling_session/cycling_session_list_screen.dart';
import 'package:hamstring_design/screen/cycling_session/cycling_session_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_confirmed_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_history_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_summary_screen.dart';
import 'package:hamstring_design/screen/payment_method/payment_method_options_screen.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/user_profile/edit_profile_screen.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/screen/wish_list/wish_list_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ProductDashboardScreen.routeName: (context) => ProductDashboardScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  WishListScreen.routeName: (context) => WishListScreen(),
  PaymentMethodOptionsScreen.routeName: (context) =>
      PaymentMethodOptionsScreen(),
  UserProfileScreen.routeName: (context) => UserProfileScreen(),
  EditProfileScreen.routeName: (context) => EditProfileScreen(),
  OrderSummaryScreen.routeName: (context) => OrderSummaryScreen(),
  AddressListScreen.routeName: (context) => AddressListScreen(
        readOnly: true,
      ),
  AddressListScreen.routeNameEdit: (context) => AddressListScreen(
        readOnly: false,
      ),
  OrderConfirmedScreen.routeName: (context) => OrderConfirmedScreen(),
  OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
  CyclingSessionScreen.routeName: (context) => CyclingSessionScreen(),
  CyclingSessionListScreen.routeName: (context) => CyclingSessionListScreen()
  // OrderStatusScreen.routeName: (context) => OrderStatusScreen(),
  // OrderDetailsScreen.routeName: (context) => OrderDetailsScreen()
};
