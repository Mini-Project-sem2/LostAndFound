import 'package:flutter/material.dart';
import 'package:lost_and_found/lost_form.dart';
import 'package:lost_and_found/services/authservice.dart';

Color blueColor = Color(0xFF1167b1);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueAccent,
            leading: Icon(
              Icons.home_filled,
              color: Color(0xFFf5f5f5),
            ),
            title: Text(
              'Home page',
            ),
            titleSpacing: 10,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () {
                  AuthService().signOut();
                },
                icon: Icon(
                  Icons.login_outlined,
                  color: Color(0xFFf5f5f5),
                ),
                label: Text(''),
              )
            ]),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              LostForm().build(context);
            },
            child: Container(
                padding: new EdgeInsets.fromLTRB(50, 10, 50, 10),
                height: 50,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.blueAccent,
                    color: blueColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('Lost',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          Container(
              padding: new EdgeInsets.fromLTRB(50, 10, 50, 10),
              height: 50,
              child: Material(
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.blueAccent,
                  color: blueColor,
                  elevation: 7.0,
                  child: Center(
                      child: Text('Found',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Trueno'))))),
        ]));
  }
}
