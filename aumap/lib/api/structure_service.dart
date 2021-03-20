import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/street.dart';
import 'package:aumap/models/structural.dart';

class S_Service {
  Future<Map> getMapData() async {
    Future.delayed(Duration(seconds: 5));

    return {
      "buildings": [
        Structural.fromjson({
          "name": "SEAS",
          "id": "0",
          "points": [
            [23.037655, 72.551796],
            [23.036837, 72.551791],
            [23.036854, 72.552561],
            [23.037655, 72.552393]
          ]
        }),
        Structural.fromjson({
          "name": "SAS",
          "id": "1",
          "points": [
            [23.037787, 72.553210],
            [23.037821, 72.554344],
            [23.037557, 72.554331],
            [23.037540, 72.553219]
          ]
        }),
      ],
      "streets": [
        Street.fromJson({
          "name": "",
          "id": 0,
          "start": [23.036756, 72.552674],
          "end": [23.037745, 72.552486]
        }),
        Street.fromJson({
          "name": "",
          "id": 1,
          "start": [23.036701, 72.551765],
          "end": [23.036722, 72.552674]
        }),
      ],
      "locations": [
        LocationPoint.fromJson({
          "id": 0,
          "name": "SEAS",
          "point": [23.03750, 72.552000]
        }),
        LocationPoint.fromJson({
          "id": 1,
          "name": "SAS",
          "point": [23.037697, 72.553712]
        }),
      ]
    };
  }
}
