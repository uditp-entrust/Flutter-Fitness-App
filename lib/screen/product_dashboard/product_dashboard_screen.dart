import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/cart_provider.dart';
import 'package:hamstring_design/provider/product_provider.dart';
import 'package:hamstring_design/screen/product_dashboard/widget/product_dashboard_appbar.dart';
import 'package:hamstring_design/screen/product_dashboard/widget/product_tabbar_view.dart';

class ProductDashboardScreen extends StatefulWidget {
  static const routeName = '/product_dashboard';

  @override
  _ProductDashboardScreenState createState() => _ProductDashboardScreenState();
}

class _ProductDashboardScreenState extends State<ProductDashboardScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  TabController tabController;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).getAllProducts("").then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String title = "Exercise & Fitness";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  void _addToCart(bool addedToCart, String productId, String productPrice) {
    double price = productPrice == null ? 0.0 : double.parse(productPrice);
    if (addedToCart == false) {
      Provider.of<CartProvider>(context, listen: false)
          .addNewItemToCart(productId, price);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    final screenWidth = getScreenWidth(context);
    final statusbarHeight = getStatusBarHeight(context);

    return Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) => WillPopScope(
              onWillPop: () async => false,
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(190),
                      child: Column(
                        children: [
                          SizedBox(
                            height: statusbarHeight,
                          ),
                          ProductDashboardAppbar(
                              getAllProducts: productProvider.getAllProducts),
                        ],
                      )),
                  body: ProductTabBarView(
                    addToCart: _addToCart,
                    productList: productProvider.productList,
                    toggleFavouriteItem: productProvider.toggleFavouriteItem,
                    imageHeight: screenHeight / 7,
                    imageTopMargin: screenHeight / 18,
                    imageLeftMargin: (((screenWidth / 2) - 6 - 10) / 2) -
                        (((screenWidth - 10) / 4) / 2),
                    imageWidth: (screenWidth - 10) / 4,
                  ),
                ),
              ),
            ));
  }
}
