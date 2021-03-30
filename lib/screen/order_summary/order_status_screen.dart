import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/screen/order_summary/order_details_screen.dart';
import 'package:hamstring_design/screen/order_summary/order_history_screen.dart';
import 'package:hamstring_design/widget/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderStatusScreen extends StatelessWidget {
  static const routeName = '/order_status';
  final DateTime orderPlacedDate;
  final String orderId;
  final int totalItems;
  final double totalAmount;

  OrderStatusScreen(
      {this.orderId, this.orderPlacedDate, this.totalAmount, this.totalItems});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(OrderHistoryScreen.routeName);
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Container(
                margin: EdgeInsets.only(
                    left: screenMargin,
                    right: screenMargin,
                    bottom: screenMargin,
                    top: screenMargin + getStatusBarHeight(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(OrderHistoryScreen.routeName);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: appbarIconSize,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Order Status',
                      style: appbarHeadingStyle,
                    ),
                  ],
                ),
              )),
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Order#:',
                          style: TextStyle(
                              fontSize: 15,
                              // color: Colors.black45,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            // '604f3e0ceef78a2d70043b47',
                            '$orderId',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 3),
                              child: Text('Order Placed On:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      // color: Colors.black45,
                                      fontWeight: FontWeight.w700))),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              // '15-Dec-2021, ',
                                              '${orderPlacedDate == null ? '' : DateFormat.yMEd().add_jms().format(orderPlacedDate)}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700)),
                                          // Container(
                                          //   margin: EdgeInsets.only(left: 3),
                                          //   child: Text('12:25 pm',
                                          //       style: TextStyle(
                                          //           fontSize: 15,
                                          //           color: Colors.black54,
                                          //           fontWeight: FontWeight.w700)),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Text(
                            'Items:',
                            style: TextStyle(
                                fontSize: 15,
                                // color: Colors.black45,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3),
                            child: Text(
                              '$totalItems',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Text(
                            'Total Amount:',
                            style: TextStyle(
                                fontSize: 15,
                                // color: Colors.black45,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3),
                            child: Text(
                              '\$${(totalAmount + 30).toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    )
                    // Container(
                    //   margin: EdgeInsets.only(top: 4),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text('4 Items',
                    //           style: TextStyle(
                    //               fontSize: 16, fontWeight: FontWeight.w700)),
                    //       Text('\$450.00',
                    //           style: TextStyle(
                    //               fontSize: 20,
                    //               color: primaryColor(context),
                    //               fontWeight: FontWeight.w800))
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    isFirst: true,
                    indicatorStyle: const IndicatorStyle(
                      width: 15,
                      color: Color(0xFFE20D31),
                      padding: EdgeInsets.all(6),
                    ),
                    endChild: const _RightChild(
                      title: 'Order Received',
                      message: '09:10 AM, 9 May 2020',
                    ),
                    beforeLineStyle: const LineStyle(
                        color: Color(0xFFE20D31), thickness: 1.4),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    indicatorStyle: const IndicatorStyle(
                      width: 15,
                      color: Color(0xFFE20D31),
                      padding: EdgeInsets.all(6),
                    ),
                    endChild: const _RightChild(
                      title: 'Order Confirmed',
                      message: '09:15 AM, 9 May 2020',
                    ),
                    beforeLineStyle: const LineStyle(
                        color: Color(0xFFE20D31), thickness: 1.4),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    indicatorStyle: const IndicatorStyle(
                      width: 15,
                      color: Color(0xFFE20D31),
                      padding: EdgeInsets.all(6),
                    ),
                    endChild: const _RightChild(
                      title: 'On the way',
                      message: '11:00 AM, 10 May 2020',
                    ),
                    beforeLineStyle: const LineStyle(
                        color: Color(0xFFE20D31), thickness: 1.4),
                    afterLineStyle:
                        const LineStyle(color: Colors.black54, thickness: 1.4),
                  ),
                  TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.1,
                    isLast: true,
                    indicatorStyle: const IndicatorStyle(
                      width: 15,
                      color: Colors.black54,
                      padding: EdgeInsets.all(6),
                    ),
                    endChild: const _RightChild(
                      disabled: true,
                      title: 'Deliverd',
                      message: 'Finish time in 1 day',
                    ),
                    beforeLineStyle:
                        const LineStyle(color: Colors.black54, thickness: 1.4),
                  ),
                ],
              )),
            ],
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(screenMargin),
            child: CustomButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(
                              orderId: orderId,
                            )));
              },
              label: 'View Order Details',
            ),
          )),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF636564),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 3),
                      child: Icon(
                        Icons.timelapse,
                        color: Colors.black54,
                        size: 20,
                      )),
                  Text(
                    message,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
