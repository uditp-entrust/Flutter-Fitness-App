import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/auth.dart';
import 'package:hamstring_design/provider/product_dashboard_provider.dart';
import 'package:hamstring_design/screen/cart/cart_screen.dart';
import 'package:hamstring_design/screen/cycling_session/cycling_session_list_screen.dart';
import 'package:hamstring_design/screen/product_dashboard/widget/product_searchbar.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/screen/wish_list/wish_list_screen.dart';
import 'package:provider/provider.dart';

class ProductDashboardAppbar extends StatefulWidget {
  final Future<void> Function(String) getAllProducts;

  ProductDashboardAppbar({this.getAllProducts});

  @override
  _ProductDashboardAppbarState createState() => _ProductDashboardAppbarState();
}

class _ProductDashboardAppbarState extends State<ProductDashboardAppbar> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductDashboardProvider>(context, listen: false)
          .getTotalCartItems()
          .then((_) {});
      Provider.of<ProductDashboardProvider>(context, listen: false)
          .getTotalFavouriteItems()
          .then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<Auth>(context);
    int numberOfCartItems =
        Provider.of<ProductDashboardProvider>(context).totalCartItems;
    int numberOfFavouriteItems =
        Provider.of<ProductDashboardProvider>(context).totalFavouriteItems;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 35,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Text('Home',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800)),
                    )
                  ],
                ),
                // SizedBox(
                //   width: 35,
                // ),
                // Text('Dashboard',
                //     style:
                //         TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                Row(
                  children: [
                    numberOfCartItems == 0
                        ? InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            },
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 30,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CartScreen.routeName);
                            },
                            child: Badge(
                              animationType: BadgeAnimationType.fade,
                              shape: BadgeShape.circle,
                              borderRadius: BorderRadius.circular(100),
                              position: BadgePosition.topEnd(top: -6, end: -12),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 30,
                              ),
                              badgeContent: Container(
                                height: 15,
                                width: 15,
                                child: Text(
                                  '$numberOfCartItems',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              badgeColor: primaryColor(context),
                            ),
                          ),
                    PopupMenuButton(
                      elevation: 3.2,
                      onSelected: (val) {
                        switch (val) {
                          case 'wishlist':
                            Navigator.of(context)
                                .pushNamed(WishListScreen.routeName);
                            break;
                          case 'userProfile':
                            Navigator.of(context).pushReplacementNamed(
                                UserProfileScreen.routeName);
                            break;
                          case 'cyclingSession':
                            Navigator.of(context).pushReplacementNamed(
                                CyclingSessionListScreen.routeName);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.favorite_border),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text('Wish List',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                            value: 'wishlist',
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'User Profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))
                              ],
                            ),
                            value: 'userProfile',
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.motorcycle_outlined),
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Cycling Session',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ))
                              ],
                            ),
                            value: 'cyclingSession',
                          )
                        ];
                      },
                    )
                    // InkWell(
                    //     onTap: () => Navigator.of(context)
                    //         .pushNamed(WishListScreen.routeName),
                    //     child: Icon(Icons.favorite_border)),
                    // InkWell(
                    //     onTap: () async {
                    //       Navigator.of(context).pushReplacementNamed(
                    //           UserProfileScreen.routeName);
                    //     },
                    //     child: Icon(Icons.person)),
                    // InkWell(
                    //     onTap: () async {
                    //       await authUser.logout();
                    //       Navigator.of(context)
                    //           .pushReplacementNamed(LoginScreen.routeName);
                    //     },
                    //     child: Icon(Icons.logout))
                  ],
                )
              ],
            ),
          ),
          ProductSearchbar(getAllProducts: widget.getAllProducts),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50.0,
              child: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Theme.of(context).primaryColor,
                  isScrollable: true,
                  tabs: productCategoriesList
                      .map(
                        (productCategory) => Tab(
                          text: productCategory,
                        ),
                      )
                      .toList())),
        ],
      ),
    );
  }
}
