import 'dart:convert';

import 'package:aumap/models/street.dart';

import 'api.dart';

class StreetService {
  String url = 'map/streets/';

  Future<List<Street>> getStreetData() async {
    List<Street> streets = [];

    await API.getrequest(url).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        streets.add(Street.fromJson(data[i]));
      }
    });
    return streets;
  }
}
