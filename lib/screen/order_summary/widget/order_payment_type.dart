import 'package:flutter/material.dart';
import 'package:hamstring_design/screen/payment_method/payment_method_options_screen.dart';

class OrderPaymentType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 20, bottom: 14),
            child: Text('Payment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: 35,
                      height: 30,
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/images/cash-payment.png',
                        fit: BoxFit.fill,
                      )),
                  Text('Cash Payment',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600))
                ],
              ),
              InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(PaymentMethodOptionsScreen.routeName),
                child: Text('Change',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFE20D31),
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        )
      ],
    );
  }
}
