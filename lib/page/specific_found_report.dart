import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/user_funtion.dart';
import '../global_constant.dart';

User? _user;
var _item;

class SpecificFoundReport extends StatelessWidget {
  SpecificFoundReport(User? user, var item) {
    _user = user;
    _item = item;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Your Found Objects'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: foundReportsList(_user, _item),
      );
}

foundReportsList(User? _user, var item) {
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<Widget>(
              future: getLostUserTiles(_user?.uid as String, item),
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

Future<Widget> getLostUserTiles(String uid, var item) async {
  List<dynamic> usersList = await getUser(uid, "lost", item);
  List<Widget> list = [];

  if (usersList.length == 0) {
    return Center(
      child: Text('No one has reported for your found items'),
    );
  }

  for (var user in usersList) {
    list.add(
      Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          textColor: Colors.black,
          tileColor: GlobalResource.TILE_COLOUR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(user['user'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Text(user['description']),
        ),
      ),
    );
  }

  return Column(children: list);
}
