import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/user_funtion.dart';

User? _user;
String? _itemid;

class SpecificLostReportsPage extends StatelessWidget {
  SpecificLostReportsPage(User? user, String? itemid) {
    _user = user;
    _itemid = itemid;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Lost Objects'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: specificLostReport(_user, _itemid),
      );
}

specificLostReport(User? _user, String? _itemid) {
  return Scaffold(
    body: Container(
      child: Column(
        children: getTiles(_user?.uid as String, _itemid as String),
      ),
    ),
  );
}

getTiles(String uid, String itemid) {
  List<dynamic> usersList = [];
  getFoundUser(uid).then((value) => usersList = value);
  List<Widget> list = [];

  if (usersList.length == 0) {
    return [
      Center(
        child: Text('No one has reported for your lost items'),
      )
    ];
  }

  for (var user in usersList) {
    list.add(
      Container(
        child: ListTile(
          title: Text(user['user']),
          subtitle: Text(user['description']),
        ),
      ),
    );
  }

  return list;
}
