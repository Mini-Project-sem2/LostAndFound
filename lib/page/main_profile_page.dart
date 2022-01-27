import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/page/profile_page.dart';

User? _user;

class MainProfilePage extends StatelessWidget {
  MainProfilePage(User? user) {
    _user = user;
  }
  static final String title = 'User Profile';
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: ProfilePage(_user),
        ),
      ),
    );
  }
}
