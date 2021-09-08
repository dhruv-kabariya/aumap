import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './converter.dart';

class Structural {
  String name;
  List<Offset> points = [];
  bool hightlight;
  Color color;

  Structural(String name, List<List<double>> loc) {
    this.name = name;
    for (int i = 0; i < loc.length; i++) {
      this.points.add(newxy(loc[i][0], loc[i][1]));
    }
  }

  Structural.fromjson(Map json) {
    this.name = json["name"];
    this.hightlight = false;
    this.color = Color((int.parse(json["marker"]["color"])));
    for (int i = 0; i < json["structural"].length; i++) {
      this.points.add(newxy(json["structural"][i]["latitude"],
          json["structural"][i]["longitude"]));
    }
  }

  void buildStrucure(Canvas c, Paint p) {
    // final Paint pain = Paint();
    p.color = Colors.black87;
    p.strokeWidth = 1;
    p.strokeCap = StrokeCap.square;

    c.drawPoints(PointMode.polygon, this.points, p);
    c.drawLine(this.points.last, this.points.first, p);

    p.color = this.color;
    Path path = Path();

    path.moveTo(points[0].dx, points[0].dy);
    path.addPolygon(points, true);

    c.drawPath(path, p);
    // c.drawShadow(path, Colors.lightBlue, 2, true);
  }
}
