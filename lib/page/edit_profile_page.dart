import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:lost_and_found/database/user_funtion.dart';
import 'package:lost_and_found/model/user.dart';
import 'package:lost_and_found/utils/user_preferences.dart';
import 'package:lost_and_found/widget/textfield_widget.dart';

auth.User? _user;

class EditProfilePage extends StatefulWidget {
  EditProfilePage(auth.User? user) {
    _user = user;
  }
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences(_user).myUser;
  bool _save = false;
  String _phoneNumber = '';
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
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {
                    if (_save) {
                      _user?.updateDisplayName(name);
                    }
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {
                    if (_save) {
                      _user?.updateEmail(email);
                    }
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Phone No',
                  text: user.phoneNo,
                  onChanged: (phoneNo) async {
                    _phoneNumber = phoneNo;
                  },
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
                      onPressed: () {
                        updatePhoneNo(_user?.uid, _phoneNumber);
                      },
                    )),
              ],
            ),
          ),
        ),
      );
}
