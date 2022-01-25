import 'package:mongo_dart/mongo_dart.dart';

import 'db_connection.dart';

void main(List<String> args) {
  crud();
}

crud() async {
  DBConnection dbc = DBConnection.getInstance();
  Db db = await dbc.getConnection();
  DbCollection coll = db.collection('found');

  await coll.insert({"brand": "redmi", "color": "black"});
  await coll.insert({"brand": "poko", "color": "blue"});
  await coll.insert({"brand": "lg", "color": "white"});
  await coll.insert({"brand": "sony", "color": "black"});
  await Future.delayed(const Duration(seconds: 10));

  var read = await coll.find(where.eq("color", "black")).toList();
  read = await coll
      .find(where.eq("color", "black").and(where.eq("brand", "redmi")))
      .toList();
  print(read);
  await Future.delayed(const Duration(seconds: 10));

  await coll.update(where.eq("brand", "lg"), modify.set("color", "red"));
  await Future.delayed(const Duration(seconds: 10));

  await coll.remove(where.eq("brand", "sony"));
  await Future.delayed(const Duration(seconds: 10));

  List<Map<String, dynamic>> mylist = await coll.find().toList();
  print(mylist[0]["brand"]);
  dbc.closeConnection();
}
