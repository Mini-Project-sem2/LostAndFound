import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/database/db_funtions.dart';
import 'package:lost_and_found/database/notify_db.dart';
import 'package:lost_and_found/database/user_funtion.dart';
import 'package:lost_and_found/home/lost_form.dart';
import 'package:lost_and_found/home/found_form.dart';
import 'package:lost_and_found/services/authservice.dart';
import 'package:lost_and_found/widget/sidebar_widget.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

Color blueColor = Color(0xFF1167b1);
User? user;

class HomePage extends StatefulWidget {
  HomePage(User? result) {
    user = result;
    initialzeUser(user);
    trackUser(user);
    Notify.notifyMe();
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SidebarWidget(user),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
            title: Text(
              'Home page',
            ),
            titleSpacing: 10,
            actions: <Widget>[
              Tooltip(
                  message: "logout",
                  triggerMode: TooltipTriggerMode.longPress,
                  child: TextButton.icon(
                    onPressed: () {
                      AuthService().signOut();
                    },
                    icon: Icon(
                      TablerIcons.logout,
                      color: Color(0xFFf5f5f5),
                    ),
                    label: Text(''),
                  ))
            ]),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              // print w3v3 value in text
              ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LostForm(user)));
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FoundForm(user)));
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
                        child: Text('Found',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
        ]));
  }
}
