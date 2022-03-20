import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lost_and_found/database/report_funtions.dart';
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
      title: Text("${_item['sub_category']} report"),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator())
                    ]);
              }),
        ],
      ),
    ),
  );
}

Future<Widget> getTiles(String uid, var item) async {
  List<Map<String, dynamic>?> usersList = await getUsers(uid, "lost", item);
  List<Widget> list = [];

  if (usersList.length == 0) {
    return Center(
      child: Text('No one has reported for your lost items'),
    );
  }

  for (Map<String, dynamic>? user in usersList) {
    if (user?['user'] != null) {
      Map<String, dynamic>? userinfo = await getUser(user?['user']);
      list.add(
        Column(children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(10),
            textColor: Colors.black,
            tileColor: GlobalResource.TILE_COLOUR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              "${userinfo?['uid'].toString()}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Icon(TablerIcons.mail,
                                  size: 10, color: Colors.black)),
                          SizedBox(width: 10.0),
                          Center(
                              child: Text('${userinfo?['email'].toString()}',
                                  style: TextStyle(fontFamily: 'Trueno'))),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ]),
      );
    }
  }

  return Column(children: list);
}
