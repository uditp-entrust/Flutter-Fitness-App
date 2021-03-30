import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cart.dart';
import 'package:hamstring_design/model/order.dart';
import 'package:hamstring_design/model/product_details.dart';

import 'package:hamstring_design/provider/cart_provider.dart';
import 'package:hamstring_design/provider/order_provider.dart';
import 'package:hamstring_design/screen/order_summary/widget/order_details.dart';
import 'package:hamstring_design/screen/payment_method/payment_method_options_screen.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:hamstring_design/widget/custom_show_dialog.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatelessWidget {
  static const routeName = '/order_summary';

  double totalAmountPrice(cartList) {
    double total = 0;
    cartList.forEach((Cart cart) {
      total += cart.totalPrice == null ? 0 : cart.totalPrice;
    });

    return total;
  }

  Future<void> orderConfirm(BuildContext context, List<Cart> cartList,
      String address, String paymentType) async {
    Order order = Order(
        product: cartList
            .map((product) => ProductDetails(
                productId: product.productId, quantity: product.productCount))
            .toList(),
        totalPrice: totalAmountPrice(cartList),
        address: address,
        paymentType: paymentType,
        deliveryCharge: 30);

    await Provider.of<OrderProvider>(context, listen: false).placeOrder(order);
    await Provider.of<CartProvider>(context, listen: false)
        .emptyCart(cartList.map((crt) => crt.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    Order orderSummary = Provider.of<OrderProvider>(context).orderSummary;
    List<Cart> cartList = Provider.of<CartProvider>(context).cartList;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(PaymentMethodOptionsScreen.routeName);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: CustomAppBar(
                  icon: Icons.arrow_back,
                  title: 'Order Summary',
                  onIconTap: () => Navigator.of(context)
                      .pushNamed(PaymentMethodOptionsScreen.routeName),
                )),
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(screenMargin),
              child: CustomButton(
                onTap: () async {
                  await orderConfirm(context, cartList, orderSummary.address,
                      orderSummary.paymentType);
                  await CustomShowDialog.customShowDialog(context, 'Suceess!',
                      'Order Placed Successfully...', 'Continue Shopping', () {
                    Navigator.of(context)
                        .pushNamed(ProductDashboardScreen.routeName);
                  });
                },
                label: 'Place Order',
              ),
            ),
            body: OrderDetails(
              orderList: cartList,
              orderContext: context,
              userAddress: '${orderSummary.userAddress.houseNumber}, Ahmedabad',
              totalAmount: totalAmountPrice(cartList),
              orderConfirm: () async {
                await orderConfirm(context, cartList, orderSummary.address,
                    orderSummary.paymentType);
                await CustomShowDialog.customShowDialog(context, 'Suceess!',
                    'Order Placed Successfully...', 'Continue Shopping', () {
                  Navigator.of(context)
                      .pushNamed(ProductDashboardScreen.routeName);
                });
              },
            )),
      ),
    );
  }
}
