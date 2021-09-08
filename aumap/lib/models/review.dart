import 'dart:convert';

import 'package:aumap/api/api.dart';

class Review {
  int id;
  String text;
  int total_like;
  OtherUser user;
  int star;
  List<String> picture = [];

  Review(
      {this.id,
      this.text,
      this.total_like,
      this.star,
      this.user,
      this.picture});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'total_like': total_like,
      'user': user.toMap(),
      'star': star,
      'picture': picture,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    List<String> temp = [];

    for (int i = 0; i < map["review_pic"].length; i++) {
      temp.add(API.url.substring(0, API.url.length - 1) +
          map["review_pic"][i]["file_name"]);
    }
    return Review(
      id: map["id"],
      text: map['text'],
      total_like: map['total_like'],
      user: OtherUser.fromMap(map['user']),
      star: map["star"],
      picture: temp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));
}

class OtherUser {
  String first_name;
  String last_name;
  String username;

  OtherUser({this.first_name, this.last_name, this.username});

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'username': username
    };
  }

  factory OtherUser.fromMap(Map<String, dynamic> map) {
    return OtherUser(
      first_name: map['first_name'],
      last_name: map['last_name'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OtherUser.fromJson(String source) =>
      OtherUser.fromMap(json.decode(source));
}
