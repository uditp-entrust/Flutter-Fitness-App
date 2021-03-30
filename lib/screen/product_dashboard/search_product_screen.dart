import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/provider/product_provider.dart';
import 'package:hamstring_design/provider/search_product_provider.dart';
import 'package:hamstring_design/screen/product_dashboard/product_dashboard_screen.dart';
import 'package:hamstring_design/screen/product_view/product_view_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class SearchProductScreen extends StatefulWidget {
  static const routeName = '/search_product';
  final String searchString;

  SearchProductScreen({this.searchString});

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context)
          .getAllProducts(widget.searchString)
          .then((_) {
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
    final screenHeight = getScreenHeight(context);
    final screenWidth = getScreenWidth(context);

    return Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) => (WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pushNamed(ProductDashboardScreen.routeName);
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(120),
                      child: CustomAppBar(
                          icon: Icons.arrow_back,
                          onIconTap: () => Navigator.of(context)
                              .pushNamed(ProductDashboardScreen.routeName),
                          title: 'Search Result')),
                  body: productProvider.productList.isEmpty
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
                            Text('No Products Found',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ))
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: productProvider.productList.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 1) {
                                return (Container(
                                    decoration: BoxDecoration(
                                  color: randomColor(),
                                  borderRadius: BorderRadius.circular(15),
                                )));
                              }
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductViewScreen(
                                            productProvider
                                                .productList[index].id))),
                                child: (Container(
                                    decoration: BoxDecoration(
                                      color: randomColor(),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: screenHeight / 18,
                                                  left: (((screenWidth / 2) -
                                                              6 -
                                                              10) /
                                                          2) -
                                                      (((screenWidth - 10) /
                                                              4) /
                                                          2)),
                                              width: (screenWidth - 10) / 4,
                                              height: screenHeight / 7,
                                              child: Image.asset(
                                                "assets/images/product-1.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 26),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${productProvider.productList[index].name}',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      '${productProvider.productList[index].company}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Text(
                                                  '\$${productProvider.productList[index].price}',
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            )
                                          ],
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: InkWell(
                                            onTap: () => productProvider
                                                .toggleFavouriteItem(
                                                    !productProvider
                                                        .productList[index]
                                                        .favourite,
                                                    productProvider
                                                        .productList[index].id,
                                                    false),
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: 45,
                                                width: 45,
                                                child: Icon(
                                                  productProvider
                                                          .productList[index]
                                                          .favourite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: primaryColor(context),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white54,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(18),
                                                    ))),
                                          ),
                                        )
                                      ],
                                    ))),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.count(2, index == 1 ? 2.3 : 3.4),
                            mainAxisSpacing: 12.0,
                            crossAxisSpacing: 12.0,
                          ),
                        )),
            ))));
  }
}
