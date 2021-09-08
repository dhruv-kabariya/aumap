import 'dart:convert';

class User {
  String first_name;
  String last_name;
  String username;
  String email;

  User({this.username, this.first_name, this.last_name, this.email});

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      first_name: map['first_name'],
      last_name: map['last_name'],
      username: map['username'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  static String signup(Map<String, String> cred) {
    return json.encode(cred);
  }

  static String login(Map<String, String> cred) {
    return json.encode(cred);
  }
}
