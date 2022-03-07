import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/user_funtion.dart';

User? _user;

class FoundReportsPage extends StatelessWidget {
  FoundReportsPage(User? user) {
    _user = user;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Found Objects'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: foundReportsList(_user),
      );
}

foundReportsList(User? _user) {
  return Scaffold(
    body: Container(
      child: Column(
        children: getLostUserTiles(_user?.uid as String),
      ),
    ),
  );
}

getLostUserTiles(String uid) {
  List<dynamic> usersList = [];
  getFoundUser(uid).then((value) => usersList = value);
  List<Widget> list = [];

  if (usersList.length == 0) {
    return [
      Center(
        child: Text('No one has reported for your found items'),
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
