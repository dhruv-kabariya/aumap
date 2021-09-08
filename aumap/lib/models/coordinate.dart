import 'dart:convert';

import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';

class Coordinate {
  double latitude;
  double longitude;
  Offset point;

  Coordinate({this.latitude, this.longitude, this.point});

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
        latitude: map['latitude'],
        longitude: map['longitude'],
        point: newxy(map['latitude'], map['longitude']));
  }

  String toJson() => json.encode(toMap());

  factory Coordinate.fromJson(String source) =>
      Coordinate.fromMap(json.decode(source));
}
