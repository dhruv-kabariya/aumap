import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationPoint {
  String name;
  Offset point;
  String website;
  String desciption;
  String marker;

  LocationPoint(
      this.name, this.point, this.desciption, this.marker, this.website);

  LocationPoint.fromJson(Map json) {
    this.name = json["p_name"];
    this.point = newxy(json["point"]["latitude"], json["point"]["longitude"]);
    this.website = json["website"];
    this.desciption = json["desciption"];
    this.marker = json["marker"]["icon"];
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
