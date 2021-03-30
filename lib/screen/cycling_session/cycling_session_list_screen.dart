import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/screen/cycling_session/cycling_session_screen.dart';
import 'package:hamstring_design/screen/cycling_session/tabs/active_session_tab.dart';
import 'package:hamstring_design/screen/cycling_session/tabs/past_sessions.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';

class CyclingSessionListScreen extends StatefulWidget {
  static const routeName = '/cycling_session_list';

  @override
  _CyclingSessionListScreenState createState() =>
      _CyclingSessionListScreenState();
}

class _CyclingSessionListScreenState extends State<CyclingSessionListScreen>
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
                      title: 'Cycling Session',
                      rightOptionLabel: 'Add New',
                      rightOptionIcon: Icons.arrow_forward,
                      onIconTap: () {
                        Navigator.of(context)
                            .pushNamed(ProductDashboardScreen.routeName);
                      },
                      onRightIconTap: () => Navigator.of(context)
                          .pushNamed(CyclingSessionScreen.routeName),
                      hasRightOption: true,
                    )),
                Container(
                    height: 30.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Theme.of(context).primaryColor,
                        tabs: ['Active Sessions', 'Past Sessions']
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
            children: [ActiveSessionTab(), PastSessions()],
          ),
        ),
      ),
    );
  }
}
