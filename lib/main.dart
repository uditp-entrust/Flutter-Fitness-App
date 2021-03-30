import 'package:flutter/material.dart';
import 'package:hamstring_design/provider/cycling_session_provider.dart';
import 'package:provider/provider.dart';

import 'package:hamstring_design/provider/address_provider.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/provider/cart_provider.dart';
import 'package:hamstring_design/provider/order_provider.dart';
import 'package:hamstring_design/provider/product_dashboard_provider.dart';
import 'package:hamstring_design/provider/product_provider.dart';
import 'package:hamstring_design/provider/search_product_provider.dart';
import 'package:hamstring_design/provider/user.dart';
import 'package:hamstring_design/provider/wish_list_provider.dart';
import 'package:hamstring_design/routes.dart';
import 'package:hamstring_design/screen/auth/login_screen.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/splash_screen/splash_screen.dart';
import 'package:hamstring_design/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, User>(
          create: (context) {
            return User(Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => User(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (context) {
            return ProductProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => ProductProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, WishListProvider>(
          create: (context) {
            return WishListProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => WishListProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, CartProvider>(
          create: (context) {
            return CartProvider(Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => CartProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          create: (context) {
            return OrderProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => OrderProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, AddressProvider>(
          create: (context) {
            return AddressProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) => AddressProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, SearchProductProvider>(
          create: (context) {
            return SearchProductProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) =>
              SearchProductProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, ProductDashboardProvider>(
          create: (context) {
            return ProductDashboardProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) =>
              ProductDashboardProvider(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, CyclingSessionProvider>(
          create: (context) {
            return CyclingSessionProvider(
                Provider.of<Auth>(context, listen: false).token,
                Provider.of<Auth>(context, listen: false).userId);
          },
          update: (_, auth, __) =>
              CyclingSessionProvider(auth.token, auth.userId),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        // home: OrderDetailsScreen(),
        home: auth.isAuthenticated
            ? ProductDashboardScreen()
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) =>
                    authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? SplashScreen()
                        : LoginScreen(),
              ),
        routes: routes,
      ),
    );
  }
}
