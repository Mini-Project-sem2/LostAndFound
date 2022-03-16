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

  if (collection == 'lost') {
    coll = db.collection('found');
  } else {
    coll = db.collection('lost');
  }

  String category = item['category'];
  var dateAndTime = item['dateAndTime'];

  List userslist = await coll.find(where.eq('category', category)).toList();

  List locationslist = [];
  switch (collection) {
    case 'lost':
      locationslist = await locationscoll
          .find(where.gte('timestamp', dateAndTime))
          .toList();
      break;
    case 'found':
      locationslist = await locationscoll
          .find(where.lte('timestamp', dateAndTime))
          .toList();
      break;
  }

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
