import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lost_and_found/utils/location_access.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

addReport({
  required User? user,
  required String category,
  required String subcategory,
  required Color color,
  required String description,
  required String date,
  required String time,
  String? endTime,
  required String collection,
}) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection(collection);
  DateTime timestamp = DateTime.parse("$date $time");
  DateTime endTimestamp = DateTime.parse("$date $endTime");

  if (collection == "found") {
    coll.insert({
      "user": user?.uid,
      "category": category.toLowerCase(),
      "sub_category": subcategory.toLowerCase(),
      "color": color.value.toString(),
      "description": description,
      "timestamp": timestamp.millisecondsSinceEpoch,
      "status": "pending",
    });
  } else {
    coll.insert({
      "user": user?.uid,
      "category": category.toLowerCase(),
      "sub_category": subcategory.toLowerCase(),
      "color": color.value.toString(),
      "description": description,
      "start_timestamp": timestamp.millisecondsSinceEpoch,
      "end_timestamp": endTimestamp.millisecondsSinceEpoch,
      "status": "pending",
    });
  }

  dbc.closeConnection();
}

void createarr(User? user) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('user_locations');

  Timer.periodic(const Duration(minutes: 5), (timer) async {
    Position position = await LocationAccess.determinePosition();

    await coll.insert({
      "user": user?.uid,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "location_lat": double.parse((position.latitude).toStringAsFixed(2)),
      "location_long": double.parse((position.longitude).toStringAsFixed(2)),
      "latitude": position.latitude,
      "longitude": position.longitude,
    });
  });
}
