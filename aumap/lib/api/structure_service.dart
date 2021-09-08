import 'dart:convert';

import 'package:aumap/api/api.dart';
import 'package:aumap/models/structural.dart';

class BuildingService {
  String url = 'map/buildings/';

  Future<List<Structural>> getBuilldingData() async {
    List<Structural> buildings = [];

    await API.getrequest(url).then((value) {
      List data = jsonDecode(value.body);
      for (int i = 0; i < data.length; i++) {
        buildings.add(Structural.fromjson(data[i]));
      }
    });

    return buildings;
  }
}
