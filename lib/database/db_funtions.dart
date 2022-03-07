import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lost_and_found/utils/location_access.dart';
import 'package:lost_and_found/utils/tracking.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

addFoundData(
  User? user,
  String categoryValue,
  String brandValue,
  String colorValue,
  String descriptionValue,
  String dateValue,
  String timeValue,
) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('found');

  coll.insert({
    "user": "${user?.uid}",
    "category": "$categoryValue",
    "brand": "$brandValue",
    "color": "$colorValue",
    "description": "$descriptionValue",
    "dateAndTime": "$dateValue $timeValue"
  });

  dbc.closeConnection();
}

addLostData(
  User? user,
  String categoryValue,
  String brandValue,
  String colorValue,
  String descriptionValue,
  String dateValue,
  String timeValue,
) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('lost');

  coll.insert({
    "user": "${user?.uid}",
    "category": "$categoryValue",
    "brand": "$brandValue",
    "color": "$colorValue",
    "description": "$descriptionValue",
    "dateAndTime": "$dateValue $timeValue"
  });

  dbc.closeConnection();
}

void createarr(User? user) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('user_locations');
  List<Position> positions = [];
  await coll.createIndex(keys: {'location': '2dsphere'});
  Timer.periodic(const Duration(minutes: 100), (timer) async {
    bool isInternetAvailable = await hasNetwork();
    var position = await LocationAccess.determinePosition();
    if (!isInternetAvailable) {
      positions.add(position);
    } else {
      if (positions.isNotEmpty) {
        while (positions.isNotEmpty) {
          Position pos = positions.removeLast();
          await coll.insert({
            "user": "${user?.uid}",
            "time": "${pos.timestamp.toString()}",
            "location": {
              "type": "Point",
              "coordinates": [pos.longitude, pos.latitude]
            }
          });
        }
      }

      await coll.insert({
        "user": "${user?.uid}",
        "time": "${position.timestamp.toString()}",
        "location": {
          "type": "Point",
          "coordinates": [position.longitude, position.latitude]
        }
      });
    }
    Fluttertoast.showToast(
        msg: "Location updated", toastLength: Toast.LENGTH_LONG);
  });
}
