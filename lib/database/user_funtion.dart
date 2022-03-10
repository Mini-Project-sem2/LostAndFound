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

  DbCollection locationscoll = db.collection('locations');
  DbCollection coll = db.collection(collection);

  var category = item['category'];
  var dateAndTime = item['dateAndTime'];

  var userslist = await coll
      .find(where.eq('category', category).gt('dateAndTime', dateAndTime))
      .toList();

  var locationslist = [];
  switch (collection) {
    case 'lost':
      locationslist = await locationscoll
          .find(where.eq('category', category).gt('dateAndTime', dateAndTime))
          .toList();
      break;
    case 'found':
      locationslist = await locationscoll
          .find(where.eq('category', category).lt('dateAndTime', dateAndTime))
          .toList();
      break;
  }

  var users = [];

  for (var location in locationslist) {
    var intersectUser = await locationscoll
        .find(where.nearSphere('coordinates', location['coordinates']))
        .toList();

    for (var user in userslist) {
      for (var intersectUser in intersectUser) {
        if (user['user'] == intersectUser['user'] &&
            compareColour(user['color'], item['color'])) {
          users.add(user);
        }
      }
    }
  }

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
