import 'dart:convert';

import './../models/location_point.dart';

import 'api.dart';

class SearchService {
  final String url = 'map/locationpoints/';

  Future<List<LocationPoint>> searchLocation(String query) async {
    List<LocationPoint> locations = [];
    String q = url + query;
    await API.getrequest(q).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        locations.add(LocationPoint.fromJson(data[i]));
      }
    });

    return locations;
  }
}
