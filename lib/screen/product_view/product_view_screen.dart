import 'package:flutter/material.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/cart_provider.dart';
import 'package:hamstring_design/provider/product_provider.dart';
import 'package:hamstring_design/screen/cart/cart_screen.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/product_view/widget/product_details.dart';
import 'package:hamstring_design/screen/product_view/widget/product_image_view.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {
  static const routeName = '/product_view';
  final String productId;

  ProductViewScreen(this.productId);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context)
          .getProduct(widget.productId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _addToCart(
      bool addedToCart, String productId, String productPrice) async {
    double price = productPrice == null ? 0.0 : double.parse(productPrice);
    if (addedToCart == false) {
      await Provider.of<CartProvider>(context, listen: false)
          .addNewItemToCart(productId, price);
    }
    // Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) => Consumer<CartProvider>(
            builder: (ctx, cartProvider, _) => WillPopScope(
                  onWillPop: () async {
                    Navigator.of(context)
                        .pushNamed(ProductDashboardScreen.routeName);
                    return true;
                  },
                  child: Scaffold(
                    body: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: getScreenHeight(context),
                                  decoration:
                                      BoxDecoration(color: randomColor()),
                                ),
                                ProductImageView(
                                  screenHeight: getScreenHeight(context) * 0.5,
                                  screenWidth: getScreenWidth(context),
                                ),
                                ProductDetails(
                                  product: productProvider.productDetails,
                                  screenHeight: getScreenHeight(context),
                                  screenWidth: getScreenWidth(context),
                                  addToCart: _addToCart,
                                  removeItem: cartProvider.removeItem,
                                  addItem: cartProvider.addItem,
                                  label:
                                      productProvider.productDetails.addedToCart
                                          ? 'View Bag'
                                          : 'Bag It',
                                  toggleFavouriteItem:
                                      productProvider.toggleFavouriteItem,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
