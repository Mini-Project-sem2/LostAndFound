import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

Future<Map<String, dynamic>?> getUser(String uid) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection collection = db.collection('user');

  Map<String, dynamic>? user = await collection.findOne(where.eq('uid', uid));
  return user;
}
