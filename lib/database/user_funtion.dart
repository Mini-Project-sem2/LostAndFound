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

Future<List<dynamic>> getFoundUser(String uid) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();

  DbCollection lostcoll = db.collection('lost');
  DbCollection locationscoll = db.collection('locations');
  DbCollection foundcoll = db.collection('found');

  var lastReport = await lostcoll.find({'user': uid}).last;
  var category = lastReport['category'];
  var dateAndTime = lastReport['dateAndTime'];

  var foundUsers = await foundcoll
      .find(where.eq('category', category).gt('dateAndTime', dateAndTime))
      .toList();

  var locations = await locationscoll
      .find(where.eq('user', uid).gt('dateAndTime', dateAndTime))
      .toList();

  var users = [];

  for (var location in locations) {
    var intersectUser = await locationscoll
        .find(where.nearSphere('coordinates', location['coordinates']))
        .toList();

    for (var foundUser in foundUsers) {
      for (var intersectUser in intersectUser) {
        if (foundUser['user'] == intersectUser['user']) {
          users.add(foundUser);
        }
      }
    }
  }

  dbc.closeConnection();

  return users;
}
