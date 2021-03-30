import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/screen/order_summary/tabs/current_orders_tab.dart';
import 'package:hamstring_design/screen/order_summary/tabs/past_orders_tab.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const routeName = '/order_history';

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150 + getStatusBarHeight(context)),
            child: Column(
              children: [
                SizedBox(
                  height: getStatusBarHeight(context),
                ),
                Container(
                    height: 120,
                    child: CustomAppBar(
                        icon: Icons.arrow_back,
                        onIconTap: () => {
                              Navigator.of(context).pushReplacementNamed(
                                  UserProfileScreen.routeName)
                            },
                        title: 'My Orders')),
                Container(
                    height: 30.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Theme.of(context).primaryColor,
                        tabs: ['Current Orders', 'Past Orders']
                            .map(
                              (productCategory) => Tab(
                                text: productCategory,
                              ),
                            )
                            .toList())),
              ],
            ),
          ),
          body: TabBarView(
            children: [CurrentOrdersTab(), PastOrdersTab()],
          ),
        ),
      ),
    );
  }
}
