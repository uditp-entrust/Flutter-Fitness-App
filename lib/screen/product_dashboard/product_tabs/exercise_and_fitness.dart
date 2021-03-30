import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/product.dart';
import 'package:hamstring_design/screen/product_view/product_view_screen.dart';

class ExerciseAndFitness extends StatelessWidget {
  final List<Product> productList;
  final Function addToCart;
  final double imageTopMargin, imageLeftMargin, imageWidth, imageHeight;
  final Future<void> Function(bool, String, bool) toggleFavouriteItem;

  ExerciseAndFitness(
      {this.productList,
      this.imageTopMargin,
      this.imageLeftMargin,
      this.imageHeight,
      this.imageWidth,
      this.addToCart,
      this.toggleFavouriteItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: productList.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset("assets/images/empty-cart.png")),
                  Text('No products found',
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
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 1) {
                      return (Container(
                        decoration: BoxDecoration(
                          color: randomColor(),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text('Flat',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  '40% OFF',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: primaryColor(context), width: 2),
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(2)),
                              alignment: Alignment.center,
                              child: Text(
                                'FITNESS SURPRICE',
                                style: TextStyle(
                                    color: primaryColor(context),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                'Use above code and get 40% discount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 8),
                            //   child: Text(
                            //     'Purchase any FITNESS product with additional 40% discount',
                            //     textAlign: TextAlign.center,
                            //     style: TextStyle(
                            //         color: Colors.black54, fontWeight: FontWeight.w700),
                            //   ),
                            // )
                          ],
                        ),
                      ));
                    }
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductViewScreen(productList[index].id))),
                      child: (Container(
                          decoration: BoxDecoration(
                            color: randomColor(),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: imageTopMargin,
                                        left: imageLeftMargin),
                                    width: imageWidth,
                                    height: imageHeight,
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
                                          '${productList[index].name}',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${productList[index].company}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('\$${productList[index].price}',
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () => toggleFavouriteItem(
                                      !productList[index].favourite,
                                      productList[index].id,
                                      false),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 45,
                                      width: 45,
                                      child: Icon(
                                        productList[index].favourite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: primaryColor(context),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
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
              ));
  }
}
