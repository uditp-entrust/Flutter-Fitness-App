import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ImageSwipe extends StatelessWidget {
  final double screenWidth;

  ImageSwipe({this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        child: Swiper(
          outer: false,
          itemBuilder: (c, i) {
            return Wrap(
              runSpacing: 6.0,
              children: [0].map((i) {
                return SizedBox(
                  width: screenWidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        child: new Container(
                            child: Image.asset(
                          "assets/images/product-1.png",
                          fit: BoxFit.fill,
                        )),
                        height: 200,
                        width: 200,
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
          pagination: SwiperPagination(margin: EdgeInsets.all(5.0)),
          itemCount: 3,
        ),
        constraints: BoxConstraints.loose(new Size(screenWidth, 140.0)));
  }
}
