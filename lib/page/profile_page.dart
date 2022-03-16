<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
=======
import 'package:firebase_auth/firebase_auth.dart' as auth;
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
import 'package:flutter/material.dart';
import 'package:lost_and_found/model/user.dart';
import 'package:lost_and_found/page/edit_profile_page.dart';
import 'package:lost_and_found/utils/user_preferences.dart';
import 'package:lost_and_found/widget/appbar_widget.dart';
import 'package:lost_and_found/widget/profile_widget.dart';

<<<<<<< HEAD
class ProfilePage extends StatefulWidget {
=======
auth.User? _user;

class ProfilePage extends StatefulWidget {
  ProfilePage(auth.User? user) {
    _user = user;
  }
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final user = UserPreferences.myUser;
    return Material(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
=======
    final user = UserPreferences(_user).myUser;
    return Material(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context, _user),
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
<<<<<<< HEAD
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
=======
                    MaterialPageRoute(
                        builder: (context) => EditProfilePage(_user)),
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
                  );
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 48),
              buildPhoneNO(user),
              const SizedBox(height: 48),
              buildAddress(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildPhoneNO(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone No',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.phoneNo,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildAddress(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.address,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
