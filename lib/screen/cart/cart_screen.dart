import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/provider/cart_provider.dart';
import 'package:hamstring_design/provider/product_dashboard_provider.dart';

import 'package:hamstring_design/screen/cart/widget/cart_list.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<CartProvider>(context).getUserCart().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  double totalAmountPrice(List<Cart> cartList) {
    double total = 0;
    cartList.forEach((Cart cart) {
      total += cart.totalPrice == null ? 0 : cart.totalPrice;
    });

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDashboardProvider>(
        builder: (ctx, productDashboardProvider, _) => Consumer<CartProvider>(
            builder: (ctx, cartProvider, _) => WillPopScope(
                  onWillPop: () async {
                    Navigator.of(context)
                        .pushNamed(ProductDashboardScreen.routeName);
                    return true;
                  },
                  child: SafeArea(
                    child: Scaffold(
                      appBar: PreferredSize(
                          preferredSize: Size.fromHeight(120),
                          child: CustomAppBar(
                              icon: Icons.arrow_back,
                              onIconTap: () => Navigator.of(context)
                                  .pushNamed(ProductDashboardScreen.routeName),
                              title: 'My Cart')),
                      body: cartProvider.cartList.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Image.asset(
                                        "assets/images/empty-cart.png")),
                                Text('Your cart is empty',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ))
                          : CartList(
                              cartList: cartProvider.cartList,
                              removeItem: cartProvider.removeItem,
                              addItem: cartProvider.addItem,
                              totalAmount:
                                  totalAmountPrice(cartProvider.cartList)),
                    ),
                  ),
                )));
  }
}
