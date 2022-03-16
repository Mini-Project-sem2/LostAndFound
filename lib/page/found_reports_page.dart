import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_and_found/global_constant.dart';
import 'package:lost_and_found/page/specific_found_report.dart';
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
        body: reportsList(_user, context),
      );
}

reportsList(User? _user, BuildContext context) {
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<Widget>(
              future: getLostUserTiles(_user?.uid as String, context),
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

Future<Widget> getLostUserTiles(String uid, BuildContext context) async {
  List<dynamic> itemsList = await getItemList(uid, "found");
  List<Widget> list = [];

  if (itemsList.length == 0) {
    return Center(
      child: Text('No one has reported for your found items'),
    );
  }

  for (var item in itemsList) {
    list.add(
      Container(
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
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
                builder: (context) => SpecificFoundReport(_user, item)));
          },
        ),
      ),
    );
  }

  return Column(children: list);
}
