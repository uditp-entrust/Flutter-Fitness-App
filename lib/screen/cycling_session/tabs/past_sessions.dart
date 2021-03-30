import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/cycling_session_provider.dart';
import 'package:provider/provider.dart';

class PastSessions extends StatefulWidget {
  @override
  _PastSessionsState createState() => _PastSessionsState();
}

class _PastSessionsState extends State<PastSessions> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<CyclingSessionProvider>(context, listen: true)
          .getCyclingActiveSessionByUser(false);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CyclingSessionProvider>(
        builder: (ctx, cyclingSessionProvider, _) => Scaffold(
                body: Container(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...cyclingSessionProvider.userCyclingSession
                          .map((orderDetails) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F3F4),
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black12, width: 1))),
                                child: Container(
                                  height: 90,
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${orderDetails.contactPersonName == null ? '' : orderDetails.contactPersonName.toUpperCase()}',
                                              style: TextStyle(
                                                  // color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.only(left: 3),
                                            //   child: Text(
                                            //     // '604f3e0ceef78a2d70043b47',
                                            //     '$orderId',
                                            //     style: TextStyle(
                                            //         color: Colors.black54,
                                            //         fontWeight:
                                            //             FontWeight.w700),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'Phone Number:  ${orderDetails.phoneNumber}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700)),
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment
                                                  //           .start,
                                                  //   children: [
                                                  //     Text(
                                                  //         'Location:  ${orderDetails.location}',
                                                  //         style: TextStyle(
                                                  //             fontSize: 15,
                                                  //             color: Colors
                                                  //                 .black45,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .w700)),
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Location:  ${orderDetails.area}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                              Text(
                                                  '${orderDetails.participateType}',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color:
                                                          primaryColor(context),
                                                      fontWeight:
                                                          FontWeight.w800))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                )
              ],
            ))));
  }
}
