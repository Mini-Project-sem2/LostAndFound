import 'package:lost_and_found/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

auth.User? _user;

class UserPreferences {
  UserPreferences(auth.User? user) {
    _user = user;
  }
  final myUser = User(
    imagePath: _user?.photoURL != null
        ? (_user?.photoURL).toString()
        : 'https://drive.google.com/file/d/1VkOpR2wsze2OAIE1rFawXr8EcAsA4JsQ/view?usp=sharing',
    name: _user?.displayName != null
        ? (_user?.displayName).toString()
        : 'Anonymous',
    email: _user?.email != null ? (_user?.email).toString() : 'Anonymous',
    phoneNo: _user?.phoneNumber != null
        ? (_user?.phoneNumber).toString()
        : 'Anonymous',
  );
}
