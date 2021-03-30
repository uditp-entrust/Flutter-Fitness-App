import 'package:flutter/material.dart';
import 'package:hamstring_design/provider/order_provider.dart';

import 'package:hamstring_design/screen/order_summary/widget/order_list_details.dart';
import 'package:provider/provider.dart';

class CurrentOrdersTab extends StatefulWidget {
  @override
  _CurrentOrdersTabState createState() => _CurrentOrdersTabState();
}

class _CurrentOrdersTabState extends State<CurrentOrdersTab> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrderProvider>(context).getOrderByUserId().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (ctx, orderProvider, _) => Scaffold(
                body: Container(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ...orderProvider.orderList
                          .map((orderDetails) =>
                              OrderListDetails(orderDetails: orderDetails))
                          .toList()
                    ],
                  ),
                )
              ],
            ))));
  }
}

// OrderListDetails
