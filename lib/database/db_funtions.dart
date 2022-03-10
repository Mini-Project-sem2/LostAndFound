import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lost_and_found/utils/location_access.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

addReport(
  User? user,
  String categoryValue,
  String brandValue,
  Color colorValue,
  String descriptionValue,
  String dateValue,
  String timeValue,
  String collection,
) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection(collection);
  DateTime dateTime = DateTime.parse("$dateValue $timeValue");

  coll.insert({
    "user": user?.uid,
    "category": categoryValue.toLowerCase(),
    "brand": brandValue.toLowerCase(),
    "color": colorValue,
    "description": descriptionValue,
    "dateAndTime": dateTime.millisecondsSinceEpoch
  });

  dbc.closeConnection();
}

void createarr(User? user) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('user_locations');
  await coll.createIndex(keys: {'location': '2dsphere'});

  Timer.periodic(const Duration(minutes: 30), (timer) async {
    Position position = await LocationAccess.determinePosition();

    await coll.insert({
      "user": user?.uid,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "location": {
        "type": "Point",
        "coordinates": [
          double.parse((position.latitude).toStringAsFixed(2)),
          double.parse((position.longitude).toStringAsFixed(2))
        ]
      }
    });
  });
}
