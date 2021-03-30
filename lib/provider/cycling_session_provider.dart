import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hamstring_design/constants.dart';
import 'package:hamstring_design/model/cycling_session.dart';
import 'package:http/http.dart' as http;

class CyclingSessionProvider with ChangeNotifier {
  final String url = '$API_URL/api';

  final String authToken;
  final String userId;

  CyclingSession _cyclingSessionSaveObj = CyclingSession();

  CyclingSession get cyclingSessionSaveObj {
    return _cyclingSessionSaveObj;
  }

  CyclingSession _cyclingSession = CyclingSession();

  CyclingSession get cyclingSession {
    return _cyclingSession;
  }

  void currentSessionDetails(
      CyclingSession currentSession, bool isAddressDetails) {
    if (isAddressDetails) {
      _cyclingSession.location = currentSession.location;
      _cyclingSession.latitude = currentSession.latitude;
      _cyclingSession.longitude = currentSession.longitude;
      _cyclingSession.area = currentSession.area;
      _cyclingSession.city = currentSession.city;
      _cyclingSession.state = currentSession.state;
      _cyclingSession.country = currentSession.country;
    } else {
      _cyclingSession.contactPersonName = currentSession.contactPersonName;
      _cyclingSession.phoneNumber = currentSession.phoneNumber;
      _cyclingSession.participateType = currentSession.participateType;
      _cyclingSession.numberOfParticipants =
          currentSession.numberOfParticipants;
      _cyclingSession.sessionHour = currentSession.sessionHour;
      _cyclingSession.sessionMinute = currentSession.sessionMinute;
      _cyclingSession..sessionDateRange = currentSession.sessionDateRange;
      _cyclingSession.selectedDays = currentSession.selectedDays;
      _cyclingSession.location = currentSession.location;
      _cyclingSession.latitude = currentSession.latitude;
      _cyclingSession.longitude = currentSession.longitude;
      _cyclingSession.area = currentSession.area;
      _cyclingSession.city = currentSession.city;
      _cyclingSession.state = currentSession.state;
      _cyclingSession.country = currentSession.country;
    }
    notifyListeners();
  }

  List<CyclingSession> _userCyclingSession = [];

  List<CyclingSession> get userCyclingSession {
    return [..._userCyclingSession];
  }

  CyclingSessionProvider(this.authToken, this.userId);

  Future<void> addNewCyclingSession(CyclingSession cyclingSession) async {
    try {
      final response = await http.post(
        '$url/cycling_address',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
        body: jsonEncode({
          'userId': userId,
          'location': cyclingSession.location,
          'area': cyclingSession.area,
          'city': cyclingSession.city,
          'state': cyclingSession.state,
          'country': cyclingSession.country,
          'latitude': cyclingSession.latitude,
          'longitude': cyclingSession.longitude,
          'phoneNumber': cyclingSession.phoneNumber,
          'contactPersonName': cyclingSession.contactPersonName,
          'participateType': cyclingSession.participateType,
          'numberOfParticipants': cyclingSession.numberOfParticipants,
          'sessionHour': cyclingSession.sessionHour,
          'sessionMinute': cyclingSession.sessionMinute,
          'selectedDays': cyclingSession.selectedDays,
          'sessionDateRange': cyclingSession.sessionDateRange
              .map((val) => val.add(new Duration(days: 1)).toIso8601String())
              .toList(),
          'type': cyclingSession.type,
          'latlong': cyclingSession.latlong
        }),
      );
      print('New address added ${jsonDecode(response.body)}');
    } catch (err) {
      print('failed to add new address $err');
      throw err;
    }
  }

  Future<void> getCyclingActiveSessionByUser(bool activeSession) async {
    String sessionUrl = activeSession
        ? '$url/cycling_address/user/$userId'
        : '$url/cycling_address/past_sessions/$userId';
    try {
      final response = await http.get(
        sessionUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );

      if (response.statusCode >= 400) {
        print('server side err ${jsonDecode(response.body)}');
        return;
      }

      final responseData = jsonDecode(response.body);
      if (responseData == null) {
        return;
      }

      _userCyclingSession.clear();
      responseData.forEach((userSession) {
        _userCyclingSession.add(CyclingSession(
            id: userSession['_id'],
            userId: userSession['userId'],
            contactPersonName: userSession['contactPersonName'],
            phoneNumber: userSession['phoneNumber'],
            participateType: userSession['participateType'],
            numberOfParticipants: userSession['numberOfParticipants'] == null
                ? '0'
                : userSession['numberOfParticipants'].toString(),
            latitude: 0.0,
            longitude: 0.0,
            area: userSession['area'],
            city: userSession['city'],
            state: userSession['state'],
            country: userSession['country'],
            location: userSession['location'],
            type: userSession['type'],
            latlong: userSession['latlong']));
      });

      notifyListeners();
    } catch (err) {
      print('failed to get cart $err');
      throw err;
    }
  }

  Future<void> getCyclingSessionById(String cyclingSessionId) async {
    try {
      final response = await http.get(
        '$url/cycling_address/$cyclingSessionId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': authToken
        },
      );
      final responseData = jsonDecode(response.body);
      List days = responseData[0]['selectedDays'] != null
          ? List.from(responseData[0]['selectedDays'])
          : null;
      List<DateTime> sessionRange = responseData[0]['sessionDateRange'] != null
          ? List.from(responseData[0]['sessionDateRange'])
              .map((val) => DateTime.parse(val))
              .toList()
          : null;

      CyclingSession cyclingSessionById = CyclingSession(
          id: cyclingSessionId,
          userId: userId,
          location: responseData[0]['location'],
          area: responseData[0]['area'],
          city: responseData[0]['city'],
          state: responseData[0]['state'],
          country: responseData[0]['country'],
          phoneNumber: responseData[0]['phoneNumber'],
          contactPersonName: responseData[0]['contactPersonName'],
          participateType: responseData[0]['participateType'],
          numberOfParticipants: '${responseData[0]['numberOfParticipants']}',
          selectedDays: days,
          sessionMinute: responseData[0]['sessionMinute'],
          sessionHour: responseData[0]['sessionHour'],
          latitude: responseData[0]['latitude'],
          longitude: responseData[0]['longitude'],
          sessionDateRange: sessionRange,
          type: responseData[0]['type'],
          latlong: responseData[0]['latlong']);
      currentSessionDetails(cyclingSessionById, false);
      notifyListeners();
    } catch (err) {
      print('faled to get record $err');
      throw err;
    }
  }
}
