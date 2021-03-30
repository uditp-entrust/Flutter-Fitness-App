import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:date_format/date_format.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamstring_design/model/address.dart';
import 'package:hamstring_design/model/cycling_session.dart';
import 'package:hamstring_design/provider/address_provider.dart';
import 'package:hamstring_design/provider/cycling_session_provider.dart';
import 'package:hamstring_design/screen/cycling_session/cycling_session_list_screen.dart';
import 'package:hamstring_design/widget/custom_textfield.dart';
import 'package:hamstring_design/widget/google_map_location.dart';
import 'package:provider/provider.dart';

class CyclingSessionScreen extends StatefulWidget {
  static const routeName = '/cycling_session';

  @override
  _CyclingSessionScreenState createState() => _CyclingSessionScreenState();
}

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class _CyclingSessionScreenState extends State<CyclingSessionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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

  var currentStep = 0;
  static CyclingSession formState = CyclingSession();
  List<String> participateTypeOption = ["personal", "group", "factories"];
  String participateType = 'personal';
  List<String> numberOfParticipateOption = ['10', '15', '20'];
  String numberOfParticipate = '10';
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  List<DateTime> selectedDateRange = [
    new DateTime.now(),
    (new DateTime.now()).add(new Duration(days: 7))
  ];
  double _lat = 23.112650;
  double _long = 72.583618;
  Completer<GoogleMapController> _controller = Completer();
  Address selectAddress;

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onMapTap(LatLng latLng) {
    setState(() {
      _lat = latLng.latitude;
      _long = latLng.longitude;
    });
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    print('value for selected time $picked');
    if (picked != null) {
      print('picker hour and minute ${picked.hour} ${picked.minute}');
      setState(() {
        selectedTime = picked;
        print('setting text field ${selectedTime.hour} ${selectedTime.minute}');
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: selectedDateRange[0],
        initialLastDate: selectedDateRange[1],
        firstDate: new DateTime(2021),
        lastDate: new DateTime(2022));
    if (picked != null && picked.length == 2) {
      setState(() {
        selectedDateRange = picked;
      });
      String startDate = formatDate(selectedDateRange[0], [
        dd,
        '/',
        mm,
      ]).toString();
      String endDate = formatDate(selectedDateRange[1], [
        dd,
        '/',
        mm,
      ]).toString();
      _dateController.text = '$startDate To $endDate';
    }
  }

  Future<void> _submit() async {
    FormState formData = _formKey.currentState;
    formData.save();
    print('formState Value ${formState.contactPersonName}');
    formState.participateType = participateType;
    formState.numberOfParticipants = numberOfParticipate;
    formState.sessionHour = selectedTime.hour;
    formState.sessionMinute = selectedTime.minute;
    formState.sessionDateRange = selectedDateRange;
    formState.longitude = selectAddress.longitude;
    formState.latitude = selectAddress.latitiude;
    formState.area = selectAddress.area;
    formState.city = selectAddress.city;
    formState.state = selectAddress.state;
    formState.country = selectAddress.country;
    formState.latlong = [selectAddress.longitude, selectAddress.latitiude];
    formState.type = 'Point';

    await Provider.of<CyclingSessionProvider>(context, listen: false)
        .addNewCyclingSession(formState);
    formData.reset();
  }

  @override
  Widget build(BuildContext context) {
    List<Address> userAddress =
        Provider.of<AddressProvider>(context).userAddresses;
    print('list of user addresses $userAddress');

    List<Step> steps = [
      Step(
        title: Text('Person'),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CustomTextField(
                  hintText: 'Contact Person Name',
                  initialValue: formState.contactPersonName == null
                      ? ''
                      : formState.contactPersonName,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required field';
                    }
                  },
                  textfieldIcon: Icon(Icons.person),
                  onSaved: (value) {
                    print('saving form data $value');
                    formState.contactPersonName = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CustomTextField(
                  keyboardType: TextInputType.phone,
                  hintText: 'Phone Number',
                  initialValue: formState.phoneNumber == null
                      ? ''
                      : formState.phoneNumber,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required field';
                    }
                    if (value.length != 10) {
                      return 'Invalid phone number';
                    }
                  },
                  textfieldIcon: Icon(Icons.phone),
                  onSaved: (value) {
                    formState.phoneNumber = value;
                  },
                ),
              )
            ],
          ),
        ),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Session'),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField(
                  items: (participateTypeOption).map((String ppt) {
                    return new DropdownMenuItem(
                        value: ppt,
                        child: Row(
                          children: <Widget>[
                            Text(ppt[0].toUpperCase() + ppt.substring(1)),
                          ],
                        ));
                  }).toList(),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.people_alt_rounded)),
                  value: participateType,
                  onChanged: (value) {
                    setState(() {
                      participateType = value;
                    });
                  },
                  hint: Text('Select Participate Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField(
                  items: (numberOfParticipateOption).map((String ppt) {
                    return DropdownMenuItem(
                        value: ppt,
                        child: Row(
                          children: <Widget>[
                            Text(ppt[0].toUpperCase() + ppt.substring(1)),
                          ],
                        ));
                  }).toList(),
                  value: numberOfParticipate,
                  onChanged: (value) {
                    setState(() => numberOfParticipate = value);
                  },
                  decoration:
                      InputDecoration(suffixIcon: Icon(Icons.person_add_alt_1)),
                  hint: Text('Select Number Of Participate'),
                  validator: (value) {
                    if (value == null) {
                      return 'Required field';
                    }
                    return null;
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  // Ref: https://www.refactord.com/guides/flutter-text-field-date-picker
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Select Start And End Date Of Session',
                          suffixIcon: Icon(Icons.date_range_rounded)),
                      controller: _dateController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Enter Time',
                          suffixIcon: Icon(Icons.timelapse_rounded)),
                      controller: _timeController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Required field';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: MultiSelect(
                    autovalidate: false,
                    titleText: "Select days",
                    validator: (value) {
                      print('validator called $value');
                      if (value == null || value == []) {
                        print('not valid $value');
                        return 'Please select one or more option(s)';
                      }
                      return null;
                    },
                    errorText: 'Please select one or more option(s)',
                    dataSource: [
                      {
                        "display": "Sunday",
                        "value": "Sunday",
                      },
                      {
                        "display": "Monday",
                        "value": "Monday",
                      },
                      {
                        "display": "Tuesday",
                        "value": "Tuesday",
                      },
                      {
                        "display": "Wednesday",
                        "value": "Wednesday",
                      },
                      {
                        "display": "Thursday",
                        "value": "Thursday",
                      },
                      {
                        "display": "Friday",
                        "value": "Friday",
                      },
                      {
                        "display": "Saturday",
                        "value": "Saturday",
                      },
                    ],
                    initialValue: formState.selectedDays == null
                        ? null
                        : formState.selectedDays,
                    textField: 'display',
                    valueField: 'value',
                    filterable: true,
                    required: true,
                    value: null,
                    onSaved: (value) {
                      formState.selectedDays = value;
                    }),
              )
            ],
          ),
        ),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text('Location'),
        content: Form(
          key: formKeys[2],
          child: DropdownButtonFormField(
            items: (userAddress).map((Address address) {
              return new DropdownMenuItem(
                  value: address,
                  child: Row(
                    children: <Widget>[
                      Text(address.landmark == null
                          ? ''
                          : '${address.landmark.toUpperCase()}'),
                    ],
                  ));
            }).toList(),
            decoration: InputDecoration(suffixIcon: Icon(Icons.place_rounded)),
            value: selectAddress,
            onChanged: (value) {
              setState(() {
                selectAddress = value;
              });
            },
            hint: Text('Select Address'),
            validator: (value) {
              if (value == null) {
                return 'Required field';
              }
              return null;
            },
          ),
        ),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: true,
      ),
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(120 + MediaQuery.of(context).padding.top),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
                Text(
                  'Add New Cycling Session',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          )),
      body: Container(
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: this.currentStep,
            steps: steps,
            type: StepperType.horizontal,
            onStepTapped: (step) {
              if (!formKeys[currentStep].currentState.validate()) {
                return;
              }
              formKeys[currentStep].currentState.save();
              setState(() {
                currentStep = step;
              });
            },
            onStepContinue: () async {
              if (!formKeys[currentStep].currentState.validate()) {
                return;
              }
              formKeys[currentStep].currentState.save();
              print('current form index $currentStep');
              if (currentStep == 1) {
                print('current index form validation');
              }
              if (currentStep == 2) {
                print('submit called');
                await _submit();
                Navigator.of(context)
                    .pushReplacementNamed(CyclingSessionListScreen.routeName);
                // setState(() {
                //   currentStep = 0;
                // });
                return;
              }
              setState(() {
                if (currentStep < steps.length - 1) {
                  if (currentStep == 0) {
                    currentStep = currentStep + 1;
                  } else if (currentStep == 1) {
                    currentStep = currentStep + 1;
                  }
                } else {
                  currentStep = 0;
                }
              });
            },
            onStepCancel: () {
              setState(() {
                if (currentStep > 0) {
                  currentStep = currentStep - 1;
                } else {
                  currentStep = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
