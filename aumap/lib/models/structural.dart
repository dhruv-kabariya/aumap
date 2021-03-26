import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './converter.dart';

class Structural {
  String name;
  List<Offset> points = [];
  bool hightlight;

  Structural(String name, List<List<double>> loc) {
    this.name = name;
    for (int i = 0; i < loc.length; i++) {
      this.points.add(newxy(loc[i][0], loc[i][1]));
    }
  }

  Structural.fromjson(Map json) {
    this.name = json["name"];
    this.hightlight = false;
    for (int i = 0; i < json["structural"].length; i++) {
      this.points.add(newxy(json["structural"][i]["latitude"],
          json["structural"][i]["longitude"]));
    }
  }

  void buildStrucure(Canvas c, Paint p) {
    c.drawPoints(PointMode.polygon, this.points, p);
    c.drawLine(this.points.last, this.points.first, p);
  }
}
