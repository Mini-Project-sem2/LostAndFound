import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/utils/reporthelper.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

void initialzeUser(User? user) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('user');
  if ((await coll.find({'uid': user?.uid}).toList()).length == 0) {
    await coll.insert({
      'uid': (user?.uid).toString(),
      'email': (user?.email).toString(),
      'displayName': (user?.displayName).toString(),
      'photoUrl': (user?.photoURL).toString(),
      'phoneNumber': (user?.phoneNumber).toString(),
      'emailVerified': (user?.emailVerified).toString(),
    });
  }
  dbc.closeConnection();
}

Future<List<dynamic>> getUser(String uid, String collection, var item) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();

  DbCollection locationscoll = db.collection('user_locations');
  DbCollection usercoll = db.collection("user");
  DbCollection coll;

  double startTimestamp;
  double endTimestamp;

  if (collection == 'lost') {
    coll = db.collection('found');
    endTimestamp = double.parse(item['timestamp'].toString());
    startTimestamp = endTimestamp - 10800000; // 3 hours
  } else {
    coll = db.collection('lost');
    startTimestamp = double.parse(item['start_timestamp'].toString());
    endTimestamp = double.parse(item['end_timestamp'].toString());
  }

  String subCategory = item['sub_category'];

  List userslist =
      await coll.find(where.eq('sub_category', subCategory)).toList();

  List locationslist = await locationscoll
      .find(
        where
            .eq('uid', uid)
            .and(where.gte('timestamp', startTimestamp))
            .and(where.lte('timestamp', endTimestamp)),
      )
      .toList();

  Set<dynamic> users = Set();
  List intersectUser = [];

  for (var location in locationslist) {
    intersectUser = await locationscoll
        .find(where
            .eq('location_lat', location['location_lat'])
            .eq('location_long', location['location_long'])
            .ne('user', uid))
        .toList();
  }

  for (var user in userslist) {
    for (var intersectUser in intersectUser) {
      if (user['user'].toString() == intersectUser['user'].toString() &&
          compareColour(int.parse(user['color'].toString()),
              int.parse(item['color'].toString()))) {
        users.add(await usercoll.findOne(where.eq('user', user['user'])));
      }
    }
  }

  dbc.closeConnection();
  return users.toList();
}

Future<List<dynamic>> getItemList(String uid, String collection) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();

  DbCollection coll = db.collection(collection);
  var items = await coll.find({'user': uid}).toList();
  dbc.closeConnection();
  return items;
}
