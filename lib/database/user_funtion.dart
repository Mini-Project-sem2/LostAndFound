import 'package:firebase_auth/firebase_auth.dart';
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

Future<List<Map<String, dynamic>?>> getUsers(
    String uid, String collection, var item) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();

  DbCollection locationscoll = db.collection('user_locations');
  DbCollection coll;

  double startTimestamp;
  double endTimestamp;

  if (collection == 'found') {
    coll = db.collection('lost');
    endTimestamp = double.parse(item['timestamp'].toString());
    startTimestamp = endTimestamp - 10800000; // 3 hours
  } else {
    coll = db.collection('found');
    startTimestamp = double.parse(item['start_timestamp'].toString());
    endTimestamp = double.parse(item['end_timestamp'].toString());
  }

  String subCategory = item['sub_category'];

  List userslist =
      await coll.find(where.eq('sub_category', subCategory)).toList();

  List locationslist = await locationscoll
      .find(
        where
            .eq('user', uid)
            .and(where.gte('timestamp', startTimestamp))
            .and(where.lte('timestamp', endTimestamp)),
      )
      .toList();

  List<Map<String, dynamic>?> users = [];
  List intersectUser = [];

  for (var location in locationslist) {
    intersectUser = await locationscoll
        .find(where
            .eq('location_lat', location['location_lat'])
            .eq('location_long', location['location_long']))
        .toList();
  }

  Set<String> intersectionSet = Set();
  for (var user in intersectUser) {
    intersectionSet.add(user['user'].toString());
  }
  print(intersectionSet.length);

  Set<String> userSet = Set();
  for (var user in userslist) {
    userSet.add(user['user'].toString());
  }

  List usersIds = userSet.intersection(intersectionSet).toList();
  for (var uid in usersIds) {
    users.add(userslist.firstWhere(((report) => report['user'] == uid)));
  }
  print("users: ${users.length}");

  dbc.closeConnection();
  return users;
}

Future<List<dynamic>> getItemList(String uid, String collection) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();

  DbCollection coll = db.collection(collection);
  var items = await coll.find({'user': uid}).toList();
  dbc.closeConnection();
  return items;
}
