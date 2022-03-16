import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/user_funtion.dart';

import '../global_constant.dart';

User? _user;
var _item;

class SpecificLostReportsPage extends StatelessWidget {
  SpecificLostReportsPage(User? user, var item) {
    _user = user;
    _item = item;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Lost Objects'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: specificLostReport(_user, _item),
      );
}

specificLostReport(User? _user, var _item) {
  return Scaffold(
    appBar: AppBar(
      title: Text("${_item['description']} report"),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    ),
    body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<Widget>(
              future: getTiles(_user?.uid as String, _item),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: snapshot.data,
                  );
                }

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()]);
              }),
        ],
      ),
    ),
  );
}

Future<Widget> getTiles(String uid, var item) async {
  List<dynamic> usersList = await getUser(uid, "found", item);
  List<Widget> list = [];

  if (usersList.length == 0) {
    return Center(
      child: Text('No one has reported for your lost items'),
    );
  }

  for (var user in usersList) {
    list.add(
      Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          textColor: Colors.black,
          selectedColor: GlobalResource.TILE_COLOUR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            user['user'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(user['description']),
        ),
      ),
    );
  }

  return Column(children: list);
}
