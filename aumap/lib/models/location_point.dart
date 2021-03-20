import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationPoint {
  int id;
  String name;
  Offset point;

  LocationPoint(String name, int id, List<double> cor) {
    this.name = name;
    this.id = id;
    this.point = newxy(cor[0], cor[1]);
  }

  LocationPoint.fromJson(Map json) {
    this.id = json["id"];
    this.name = json["name"];
    this.point = newxy(json["point"][0], json["point"][1]);
  }

  void markLocation(Canvas c, Paint p) {
    p.color = Colors.greenAccent;
    c.drawCircle(point, 5, p);

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );
    final textSpan = TextSpan(
      text: name,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final offset = Offset(point.dx + 5, point.dy + 5);
    textPainter.paint(c, offset);
  }
}
