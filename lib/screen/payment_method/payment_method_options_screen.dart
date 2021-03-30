import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/order_provider.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_summary_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class PaymentMethodOptionsScreen extends StatelessWidget {
  static const routeName = '/payment_method_options';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(AddressListScreen.routeName);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: CustomAppBar(
                  icon: Icons.arrow_back,
                  title: 'Payment Methods',
                  onIconTap: () => Navigator.of(context)
                      .pushNamed(AddressListScreen.routeName),
                )),
            body: Container(
              margin: EdgeInsets.all(screenMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Current Methods'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      )),
                  InkWell(
                    onTap: () => {
                      Provider.of<OrderProvider>(context, listen: false)
                          .addPaymentType(),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderSummaryScreen())),
                    },
                    child: Card(
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 40,
                                    height: 45,
                                    margin: EdgeInsets.only(right: 25),
                                    child: Image.asset(
                                      'assets/images/cash-payment.png',
                                      fit: BoxFit.fill,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cash Payment',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text('Default Method',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54))
                                  ],
                                ),
                              ],
                            ),
                            Container(
                                height: 22,
                                width: 22,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(2)),
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 16,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Select Other Payment Type'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      )),
                  Card(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 50,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 25),
                                  child: Image.asset(
                                    'assets/images/master-card.png',
                                    fit: BoxFit.fill,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '**** **** **** 5967',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text('Expire: 09/20',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 50,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 25),
                                  child: Image.asset(
                                    'assets/images/visa-card.png',
                                    fit: BoxFit.fill,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '**** **** **** 3802',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text('Expire: 10/27',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  margin: EdgeInsets.only(right: 25),
                                  child: Image.asset(
                                    'assets/images/paypal.png',
                                    fit: BoxFit.fill,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'petra_stark@gmail.com',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
