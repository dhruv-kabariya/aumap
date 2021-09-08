import 'dart:convert';

import '../models/coordinate.dart';
import '../models/location_point.dart';
import 'api.dart';

class RouteService {
  final String url = 'map/findroute/';

  Future<List<Coordinate>> findRoute(
      LocationPoint start, LocationPoint end) async {
    List<Coordinate> route = [];
    String q = url + start.name + "/" + end.name;
    await API.getrequest(q).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        route.add(Coordinate.fromMap(data[i]));
      }
    });

    return route;
  }
}
