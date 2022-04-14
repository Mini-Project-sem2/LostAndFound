import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:lost_and_found/database/db_connection.dart';
import 'package:lost_and_found/global_constant.dart';
import 'package:lost_and_found/services/notification.dart';
import 'package:lost_and_found/utils/location_access.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Notify {
  static int _documents = 0;
  static int _previous = 0;

  static final TrackItNotification notification = new TrackItNotification();

  static void setDocsize() async {
    try {
      DBConnection dbc = DBConnection.getInstance();
      Db db = await dbc.getConnection();
      DbCollection coll = db.collection("lost");

      _documents = await coll.find().length;
    } catch (e) {
      logger.d(e.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> getLostReports() async {
    setDocsize();
    DBConnection dbc = DBConnection.getInstance();
    Db db = await dbc.getConnection();
    DbCollection coll = db.collection("lost");
    int temp = _previous;
    _previous = _documents;
    return await coll.find().skip(temp).toList();
  }

  static void notifyMe() async {
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      List<Map<String, dynamic>> lostReports = await getLostReports();
      Position position = await LocationAccess.determinePosition();

      DBConnection dbc = DBConnection.getInstance();
      Db db = await dbc.getConnection();
      DbCollection locationscoll = db.collection("user_locations");

      for (Map<String, dynamic> report in lostReports) {
        // print(report['start_timestamp']);
        // double startTimestamp =
        //     double.parse(report['start_timestamp'].toString());
        // double endTimestamp = double.parse(report['end_timestamp'].toString());
        List locationslist = await locationscoll
            .find(where
                .eq('user', report['user'])
                .gte('timestamp', report['start_timestamp'])
                .lte('timestamp', report['end_timestamp'])
                .eq("location_lat",
                    double.parse((position.latitude).toStringAsFixed(2)))
                .eq("location_long",
                    double.parse((position.latitude).toStringAsFixed(2))))
            .toList();
        if (locationslist.length > 0) {
          notification.showNotification(
              report['category'], report['sub_category']);
        }
      }
    });
  }
}
