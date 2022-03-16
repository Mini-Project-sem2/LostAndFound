import 'package:lost_and_found/model/user.dart';
<<<<<<< HEAD

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    phoneNo: '9787256548',
    address:
        'Laxmi CHS Room No - 676, Plot No - 298, Sec - 01, Ghansoli, Navi Mumbai - 400701',
    isDarkMode: false,
=======
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
>>>>>>> 48b142eb6f37215b1c2a69d9996768ca85f4a42e
  );
}
