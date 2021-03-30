import 'package:flutter/material.dart';
import 'package:hamstring_design/provider/product_provider.dart';
import 'package:hamstring_design/screen/product_dashboard/search_product_screen.dart';
import 'package:provider/provider.dart';

class ProductSearchbar extends StatefulWidget {
  final Future<void> Function(String) getAllProducts;

  ProductSearchbar({this.getAllProducts});

  @override
  _ProductSearchbarState createState() => _ProductSearchbarState();
}

class _ProductSearchbarState extends State<ProductSearchbar> {
  final TextEditingController _searchbarController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        height: 45.0,
        child: TextField(
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                hintText: 'Search here',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 19.0, vertical: 12.5)),
            controller: _searchbarController,
            onChanged: (value) {
              TextSelection previousSelection = _searchbarController.selection;
              widget.getAllProducts(value);

              // setState(() {
              _searchbarController.text = value;
              _searchbarController.selection = previousSelection;
              // });
            }

            // onSubmitted: (String searchString) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               SearchProductScreen(searchString: searchString)));
            //   _searchbarController.clear();
            // }
            ));
  }
}
