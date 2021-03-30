import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfOrderPlaced extends StatelessWidget {
  final DateTime orderPlacedDate;

  DateOfOrderPlaced({this.orderPlacedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        // '15-Dec-2021, ',
                        '${orderPlacedDate == null ? '' : DateFormat.yMEd().add_jms().format(orderPlacedDate)}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.w700)),
                    // Container(
                    //   margin: EdgeInsets.only(left: 3),
                    //   child: Text(
                    //       // '12:25 pm',
                    //       '$orderPlacedDate',
                    //       style: TextStyle(
                    //           fontSize: 15,
                    //           color: Colors.black45,
                    //           fontWeight: FontWeight.w700)),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
