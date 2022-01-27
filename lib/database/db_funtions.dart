import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/utils/location_access.dart';
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
  Timer.periodic(const Duration(seconds: 30), (timer) async {
    var position = await LocationAccess.determinePosition();

    await coll.insert({
      "user": "${user?.uid}",
      "time": "${position.timestamp.toString()}",
      "location": {
        "latitude": "${position.latitude.toString()}",
        "longitude": "${position.longitude.toString()}"
      }
    });
  });
}
