import 'package:lost_and_found/utils/user_builder.dart';

class User {
  String? _name;
  String? _mail;
  static String? _photoUrl;

  User(UserBuilder userBuilder) {
    _name = userBuilder.name;
    _mail = userBuilder.mail;
    _photoUrl = userBuilder.photourl;
  }

  String? get name => _name;
  String? get email => _mail;
  String? get photourl => _photoUrl;
  static bool dpexist() => _photoUrl != null;
}
