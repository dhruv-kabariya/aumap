import 'dart:convert';

import 'package:aumap/api/api.dart';
import 'package:aumap/models/review.dart';
import 'package:http/http.dart' as http;

class LikeService {
  Future<bool> likecheck(Review review, String username) async {
    final String url = 'map/likecheck/${review.id.toString()}/';

    return await http.post(
      Uri.parse(API.url + url),
      body: jsonEncode({"user": username}),
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8'
      },
    ).then((value) {
      return value.statusCode == 204 ? true : false;
    });
  }

  Future<bool> like(Review review, String username) async {
    final String url = 'map/like/${review.id.toString()}/';

    return await http.post(
      Uri.parse(API.url + url),
      body: jsonEncode({"user": username}),
      headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8'
      },
    ).then((value) {
      return value.statusCode == 204 ? true : false;
    });
  }
}
