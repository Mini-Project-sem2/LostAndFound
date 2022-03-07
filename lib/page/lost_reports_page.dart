import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/user_funtion.dart';

User? _user;

class LostReportsPage extends StatelessWidget {
  LostReportsPage(User? user) {
    _user = user;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Lost Objects'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: lostReportsList(_user),
      );
}

lostReportsList(User? _user) {
  return Scaffold(
    body: Container(
      child: Column(
        children: getFoundUserTiles(_user?.uid as String),
      ),
    ),
  );
}

getFoundUserTiles(String uid) {
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
