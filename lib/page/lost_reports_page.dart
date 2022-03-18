import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/database/user_funtion.dart';
import 'package:lost_and_found/page/specific_lost_report.dart';

import '../global_constant.dart';

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
        body: lostReportsList(_user, context),
      );
}

lostReportsList(User? _user, BuildContext context) {
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<Widget>(
              future: getFoundUserTiles(_user?.uid as String, context),
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

Future<Widget> getFoundUserTiles(String uid, BuildContext context) async {
  List<dynamic> itemList = await getItemList(uid, "lost");
  List<Widget> list = [];

  if (itemList.length == 0) {
    return Center(
      child: Text('You have not reported any items'),
    );
  }

  for (var item in itemList) {
    list.add(
      Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(25),
            textColor: Colors.black,
            tileColor: GlobalResource.TILE_COLOUR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              item['category'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['description']),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => specificLostReport(_user, item)));
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  return Column(children: list);
}
