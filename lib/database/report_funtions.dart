import 'package:mongo_dart/mongo_dart.dart';
import 'db_connection.dart';

Future<List<dynamic>> getReports(String uid, String collection) async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection collection = db.collection('reports');
  List<dynamic> reports = await collection.find(where.eq("user", uid)).toList();
  return reports;
}
