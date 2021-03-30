import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/address.dart';
import 'package:hamstring_design/provider/address_provider.dart';
import 'package:hamstring_design/provider/user.dart';
import 'package:hamstring_design/screen/address/address_list_screen.dart';
import 'package:provider/provider.dart';

class AddNewAddressScreen extends StatefulWidget {
  final double lat;
  final double long;
  final Address address;
  final String addressId;

  AddNewAddressScreen({this.lat, this.long, this.addressId, this.address});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<FormState> _formKey = GlobalKey();

  double _lat;
  double _long;
  bool _isLoading = false;

  String addressType = 'home';
  Map _userAddress = {
    'house': '',
    'landmark': '',
    'latitude': 0.0,
    'longitude': 0.0,
    'addressType': 'home',
    'area': 'Chandkheda',
    'city': 'Ahmedabad',
    'state': 'Gujarat',
    'country': 'India'
  };

  void initState() {
    _lat = widget.lat;
    _long = widget.long;
    addressType = widget.address == null ? 'home' : widget.address.addressType;
    super.initState();
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    final userDetails = Provider.of<User>(context, listen: false).userDetail;
    _userAddress['latitude'] = _lat;
    _userAddress['longitude'] = _long;
    _userAddress['addressType'] = addressType;
    _userAddress['userName'] =
        '${userDetails['firstName']} ${userDetails['lastName']}';
    _userAddress['phoneNumber'] = '${userDetails['phoneNumber']}';
    _userAddress['type'] = "Point";
    _userAddress['location'] = [_long, _lat];
    try {
      if (widget.addressId == null) {
        await Provider.of<AddressProvider>(context, listen: false)
            .addNewAddress(_userAddress);
      } else {
        await Provider.of<AddressProvider>(context, listen: false)
            .updateAddress(widget.address.id, _userAddress);
      }

      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: widget.addressId == null ? "Address added" : "Address updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddressListScreen(
                    readOnly: false,
                  )));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: widget.addressId == null
              ? "Failed To add address"
              : "Failed To update address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      print('failed address operation ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(AddressListScreen.routeNameEdit);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _lat,
                      _long,
                    ),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (LatLng latLng) => {
                        setState(() {
                          _lat = latLng.latitude;
                          _long = latLng.longitude;
                        })
                      },
                  markers: {
                    Marker(
                      markerId: MarkerId('m1'),
                      draggable: true,
                      position: LatLng(
                        _lat,
                        _long,
                      ),
                    ),
                  }),
              DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.2,
                maxChildSize: 0.62,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Form(
                    key: _formKey,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(12, 34, 12, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          Text(
                                            'Chandkheda',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Text(
                                          'Chandkheda, Ahmedabad, Gujarat, India'))
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    initialValue: widget.address == null
                                        ? ''
                                        : widget.address.houseNumber,
                                    style: regularDarkText,
                                    decoration: InputDecoration(
                                      hintText: 'House / Flat / Block No.',
                                    ),
                                    enabled: !_isLoading,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userAddress['house'] = value;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: widget.address == null
                                        ? ''
                                        : widget.address.landmark,
                                    style: regularDarkText,
                                    decoration: InputDecoration(
                                      hintText: 'Landmark',
                                    ),
                                    enabled: !_isLoading,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Required field';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userAddress['landmark'] = value;
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 14),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SAVE AS',
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: addressType ==
                                                              'home'
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.white,
                                                      width: 2))),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  onTap: () => setState(() =>
                                                      addressType = 'home'),
                                                  child: Icon(
                                                    Icons.home,
                                                    color: addressType == 'home'
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.black,
                                                  )),
                                              InkWell(
                                                onTap: () => setState(
                                                    () => addressType = 'home'),
                                                child: Text('Home',
                                                    style: TextStyle(
                                                        color: addressType ==
                                                                'home'
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.black,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: addressType ==
                                                              'work'
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.white))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () => setState(
                                                    () => addressType = 'work'),
                                                child: Icon(
                                                  Icons.work,
                                                  color: addressType == 'work'
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => setState(
                                                    () => addressType = 'work'),
                                                child: Text('Work',
                                                    style: TextStyle(
                                                        color: addressType ==
                                                                'work'
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.black,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: addressType ==
                                                              'other'
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.white))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                  onTap: () => setState(() =>
                                                      addressType = 'other'),
                                                  child: Icon(
                                                      Icons.location_searching,
                                                      color: addressType ==
                                                              'other'
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.black)),
                                              InkWell(
                                                onTap: () => setState(() =>
                                                    addressType = 'other'),
                                                child: Text('Other',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: addressType ==
                                                                'other'
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.black)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (_isLoading)
                              CircularProgressIndicator()
                            else
                              GestureDetector(
                                onTap: _submit,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  height: 43,
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Text('Save'.toUpperCase(),
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(AddressListScreen.routeNameEdit),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                height: 43,
                                width: MediaQuery.of(context).size.width - 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Text('Cancel'.toUpperCase(),
                                    style: TextStyle(
                                        color: primaryColor(context),
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        )),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
