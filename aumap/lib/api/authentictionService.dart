import 'dart:convert';

import 'package:aumap/models/user.dart';

import 'api.dart';

class AuthenticationService {
  Future<dynamic> login(String username, String password) async {
    final String url = 'map/login/';

    final String body =
        User.login({"username": username, "password": password});
    User user;
    return await API.postrequest(url, body).then((value) {
      Map data = jsonDecode(value.body);
      print(data);

      return user = User.fromMap(data);
    });
  }

  Future<User> signUp(String username, String first_name, String last_name,
      String email, String password) async {
    final String url = 'map/signup/';

    final String body = User.signup({
      "username": username,
      "password": password,
      "first_name": first_name,
      "last_name": last_name,
      "email": email
    });
    User user;
    await API.postrequest(url, body).then((value) {
      Map data = jsonDecode(value.body);
      user = User.fromMap(data);
    });

    return user;
  }
}
