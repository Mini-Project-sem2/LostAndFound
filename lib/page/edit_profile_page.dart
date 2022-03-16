<<<<<<< HEAD
import 'dart:io';

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:lost_and_found/model/user.dart';
import 'package:lost_and_found/utils/user_preferences.dart';
import 'package:lost_and_found/widget/appbar_widget.dart';
import 'package:lost_and_found/widget/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:lost_and_found/themes.dart';
import 'package:lost_and_found/widget/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
=======
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:lost_and_found/model/user.dart';
import 'package:lost_and_found/utils/user_preferences.dart';
import 'package:lost_and_found/widget/profile_widget.dart';
import 'package:lost_and_found/widget/textfield_widget.dart';

auth.User? _user;

class EditProfilePage extends StatefulWidget {
  EditProfilePage(auth.User? user) {
    _user = user;
  }
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
<<<<<<< HEAD
  User user = UserPreferences.myUser;
=======
  User user = UserPreferences(_user).myUser;
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e

  @override
  Widget build(BuildContext context) => Material(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              leading: BackButton(),
              title: Text("edit profile"),
              centerTitle: true,
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Phone No',
                  text: user.phoneNo,
                  onChanged: (phoneNo) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Address',
                  text: user.address,
                  maxLines: 2,
                  onChanged: (address) {},
                ),
                const SizedBox(height: 24),
                Padding(
                    padding: EdgeInsets.all(0.0),
                    child: ElevatedButton(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Trueno'),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        elevation: 20,
                        minimumSize: Size(500, 50),
                        shadowColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {},
                    )),
              ],
            ),
          ),
        ),
      );
}
