import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/order_items.dart';
import 'package:hamstring_design/model/product_details.dart';
import 'package:hamstring_design/provider/order_provider.dart';
import 'package:hamstring_design/screen/order_summary/order_status_screen.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = '/order_details';
  final String orderId;

  OrderDetailsScreen({this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrderProvider>(context)
          .getOrderById(widget.orderId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  int totalItems(orderItems) {
    double numberOfItmes = 0.0;
    orderItems.forEach((OrderItems productDetails) {
      numberOfItmes += productDetails.quantity;
    });

    return numberOfItmes.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (ctx, orderProvider, _) => WillPopScope(
              onWillPop: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderStatusScreen(
                            orderId: orderProvider.orderDetails.id,
                            totalAmount: orderProvider.orderDetails.totalPrice,
                            orderPlacedDate:
                                orderProvider.orderDetails.createdAt,
                            totalItems: totalItems(
                                orderProvider.orderDetails.orderItems == null
                                    ? []
                                    : orderProvider.orderDetails.orderItems))));
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderStatusScreen(
                                                    orderId:
                                                        orderProvider
                                                            .orderDetails.id,
                                                    totalAmount:
                                                        orderProvider
                                                            .orderDetails
                                                            .totalPrice,
                                                    orderPlacedDate:
                                                        orderProvider
                                                            .orderDetails
                                                            .createdAt,
                                                    totalItems: totalItems(
                                                        orderProvider
                                                                    .orderDetails
                                                                    .orderItems ==
                                                                null
                                                            ? []
                                                            : orderProvider
                                                                .orderDetails
                                                                .orderItems))));
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
                              'Order Details',
                              style: appbarHeadingStyle,
                            ),
                          ],
                        ),
                      )),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ...orderProvider.orderDetails.orderItems ==
                                            null
                                        ? []
                                        : orderProvider.orderDetails.orderItems
                                            .map((orderItem) => Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black54),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  child: Container(
                                                                      alignment: Alignment.center,
                                                                      child: Text(
                                                                        '${orderItem.quantity.toInt()}',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      ))),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            9),
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.55,
                                                                      child:
                                                                          Text(
                                                                        orderItem
                                                                            .product
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w700),
                                                                      )),
                                                                  Text(
                                                                    'Price: \$${orderItem.product.price}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            '\$${(orderItem.product.price != null ? double.parse(orderItem.product.price) * orderItem.quantity : 0)?.toStringAsFixed(2)}',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Color(
                                                                    0xFFE20D31)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 7),
                                                      child: Divider(
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ))
                                            .toList()
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sub Total',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        '\$${orderProvider.orderDetails.totalPrice?.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery Charges',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600)),
                                    Text('\$30.00',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                        '\$${((orderProvider.orderDetails.totalPrice == null || orderProvider.orderDetails.deliveryCharge == null) ? 0 : orderProvider.orderDetails.totalPrice + orderProvider.orderDetails.deliveryCharge).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30,
                                            letterSpacing: 0.7))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text('Address',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        // height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                            '${orderProvider.orderDetails.address == null ? '' : orderProvider.orderDetails.address}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 14),
                                  child: Text('Payment',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800))),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Text(
                                          '${orderProvider.orderDetails.paymentType == null ? '' : orderProvider.orderDetails.paymentType}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ));
  }
}
