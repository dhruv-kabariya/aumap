import 'dart:convert';

import 'package:aumap/models/location_point.dart';

import 'api.dart';

class LocationPointService {
  String url = 'map/locationpoints/';

  Future<List<LocationPoint>> getLocationPointData() async {
    List<LocationPoint> locations = [];

    await API.getrequest(url).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        locations.add(LocationPoint.fromJson(data[i]));
      }
    });

    return locations;
  }
}
