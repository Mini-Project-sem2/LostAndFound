import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/home/home_page.dart';

User? _user;
AppBar buildAppBar(BuildContext context, User? user) {
  _user = user;
  return AppBar(
    leading: BackButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage(_user)),
        );
      },
    ),
    title: Text("your profile"),
    centerTitle: true,
    backgroundColor: Colors.blue,
    elevation: 0,
  );
}
