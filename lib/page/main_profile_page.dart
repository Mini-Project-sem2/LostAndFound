<<<<<<< HEAD
// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lost_and_found/page/profile_page.dart';
import 'package:lost_and_found/themes.dart';
import 'package:lost_and_found/utils/user_preferences.dart';

class MainProfilePage extends StatelessWidget {
  static final String title = 'User Profile';
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Material(
      // initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeProvider.of(context),
          title: title,
          home: ProfilePage(),
=======
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
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
        ),
      ),
    );
  }
}
<<<<<<< HEAD


=======
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
