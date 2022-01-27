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
        : 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
    name: _user?.displayName != null
        ? (_user?.displayName).toString()
        : 'Anonymous',
    email: _user?.email != null ? (_user?.email).toString() : 'Anonymous',
    phoneNo: _user?.phoneNumber != null
        ? (_user?.phoneNumber).toString()
        : 'Anonymous',
    address:
        'Laxmi CHS Room No - 676, Plot No - 298, Sec - 01, Ghansoli, Navi Mumbai - 400701',
  );
}
