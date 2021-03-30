import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/widget/secondary_button.dart';

class OrderConfirmedScreen extends StatelessWidget {
  static const routeName = '/order_confirmed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.all(value),
        color: primaryColor(context),
        height: getScreenHeight(context),
        width: getScreenWidth(context),
        child: Container(
          margin: EdgeInsets.all(screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.done_rounded,
                        size: 90,
                        color: primaryColor(context),
                      ))),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Text(
                  'Order Confirmed',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      'Thank you for your order. You will ',
                      textAlign: TextAlign.center,
                      style: orderConfirmationMessageStyle,
                    ),
                    Text(
                      'receive email confirmation sortly',
                      textAlign: TextAlign.center,
                      style: orderConfirmationMessageStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    'Check the status of your order ',
                    style: orderConfirmationMessageStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'on the ',
                        style: orderConfirmationMessageStyle,
                      ),
                      Text(
                        'Order Tracking ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'page',
                        style: orderConfirmationMessageStyle,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 40,
              ),
              SecondaryButton(
                label: 'Continue Shopping',
              )
            ],
          ),
        ),
      ),
    );
  }
}
