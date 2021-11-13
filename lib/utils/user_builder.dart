// ignore_for_file: empty_constructor_bodies

class UserBuilder {
  String? _name;
  String? _mail;
  String? _photoUrl;

  UserBuilder(UserBuilder userBuilder);

  UserBuilder withName(String name) {
    _name = name;
    return this;
  }

  UserBuilder withMail(String mail) {
    _mail = mail;
    return this;
  }

  UserBuilder withPhotoUrl(String? photoUrl) {
    _photoUrl = photoUrl;
    return this;
  }

  String? get name => _name;
  String? get mail => _mail;
  String? get photourl => _photoUrl;

  UserBuilder build() {
    return new UserBuilder(this);
  }
}
