import 'package:flutter/material.dart';

import 'package:hamstring_design/provider/wish_list_provider.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/product_view/product_view_screen.dart';
import 'package:hamstring_design/screen/wish_list/widget/wish_list_item.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = '/wish_list';

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<WishListProvider>(context).getFavouriteByUse().then((_) {
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
    return Consumer<WishListProvider>(
        builder: (ctx, favouriteProvider, _) => WillPopScope(
              onWillPop: () async {
                Navigator.of(context)
                    .pushNamed(ProductDashboardScreen.routeName);
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(120),
                      child: CustomAppBar(
                        icon: Icons.arrow_back,
                        title: 'Wish List',
                        onIconTap: () => Navigator.of(context)
                            .pushNamed(ProductDashboardScreen.routeName),
                      )),
                  body: favouriteProvider.favouriteList.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                    "assets/images/empty-cart.png")),
                            Text('Your wish list is empty',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ))
                      : Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  ...favouriteProvider.favouriteList
                                      .map((cartItem) => InkWell(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductViewScreen(
                                                            cartItem
                                                                .product.id))),
                                            child: WishListItem(
                                                cartItem: cartItem,
                                                wishListContext: context,
                                                removeFavouriteItem:
                                                    favouriteProvider
                                                        .removeFavouriteItem),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                          ],
                        )),
                ),
              ),
            ));
  }
}
