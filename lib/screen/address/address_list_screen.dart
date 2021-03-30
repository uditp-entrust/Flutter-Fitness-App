import 'package:flutter/material.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/address_model.dart';
import 'package:hamstring_design/provider/address_provider.dart';
import 'package:hamstring_design/provider/order_provider.dart';
import 'package:hamstring_design/screen/address/add_new_address_screen.dart';
import 'package:hamstring_design/screen/cart/cart_screen.dart';
import 'package:hamstring_design/screen/payment_method/payment_method_options_screen.dart';
import 'package:hamstring_design/screen/user_profile/user_profile_screen.dart';
import 'package:hamstring_design/widget/custom_appbar.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  static const routeName = '/address_list';
  static const routeNameEdit = '/address_list_edit';
  final bool readOnly;

  AddressListScreen({this.readOnly = true});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AddressProvider>(context).getUserAddress().then((_) {
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
    return Consumer<AddressProvider>(
        builder: (ctx, addressProvider, _) => WillPopScope(
              onWillPop: () async {
                if (widget.readOnly) {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                } else {
                  Navigator.of(context).pushNamed(UserProfileScreen.routeName);
                }
                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: PreferredSize(
                      preferredSize: Size.fromHeight(120),
                      child: CustomAppBar(
                        icon: Icons.arrow_back,
                        title: widget.readOnly
                            ? 'Choose Delivery Address'
                            : 'My Addresses',
                        rightOptionLabel: 'Add New',
                        rightOptionIcon: Icons.arrow_forward,
                        onIconTap: () {
                          if (widget.readOnly) {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          } else {
                            Navigator.of(context)
                                .pushNamed(UserProfileScreen.routeName);
                          }
                        },
                        onRightIconTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewAddressScreen(
                                      lat: 23.112650,
                                      long: 72.583618,
                                    ))),
                        hasRightOption: !widget.readOnly,
                      )),
                  body: addressProvider.userAddresses.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                    "assets/images/empty-address.png")),
                            Text('You have not added delivery address yet',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500)),
                            if (widget.readOnly)
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                    'Please add delivery address from user settings',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400)),
                              )
                          ],
                        ))
                      : Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  ...addressProvider.userAddresses
                                      .map((address) => Dismissible(
                                            key: Key(address.id.toString()),
                                            direction: widget.readOnly
                                                ? null
                                                : DismissDirection.endToStart,
                                            background: Container(
                                              margin:
                                                  EdgeInsets.only(right: 40),
                                              alignment: Alignment.centerRight,
                                              child: Icon(Icons.delete),
                                            ),
                                            onDismissed: (diresction) {
                                              if (!widget.readOnly) {
                                                addressProvider
                                                    .deleteAddress(address.id);
                                              }
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                if (widget.readOnly) {
                                                  Provider.of<OrderProvider>(
                                                          context,
                                                          listen: false)
                                                      .addUserAddress(address);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PaymentMethodOptionsScreen()));
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF2F3F4),
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black12,
                                                            width: 1))),
                                                child: Container(
                                                  height: 90,
                                                  margin: EdgeInsets.all(10),
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              address.userName,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            if (!widget
                                                                .readOnly)
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => AddNewAddressScreen(
                                                                              address: address,
                                                                              lat: address.latitiude,
                                                                              long: address.longitude,
                                                                              addressId: address.id)));
                                                                },
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  size: 20,
                                                                  color: primaryColor(
                                                                      context),
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    child: Icon(
                                                                      Icons
                                                                          .phone,
                                                                      color: Colors
                                                                          .black54,
                                                                      size: 20,
                                                                    ),
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                5),
                                                                  ),
                                                                  Text(
                                                                    address
                                                                        .phoneNumber,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        size:
                                                                            20,
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              5)),
                                                                  Text(
                                                                    '${address.houseNumber} ${address.area} ${address.city} ${address.state}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ],
                              ),
                            )
                          ],
                        )),
                ),
              ),
            ));
  }
}
