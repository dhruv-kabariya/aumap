import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LocationPoint {
  String name;
  Offset point;
  String website;
  String desciption;
  String marker;
  bool highlight = false;

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
    final location = Icons.location_on;

    final textStyle = GoogleFonts.lato(fontSize: 13);
    final textSpan = TextSpan(
      text: String.fromCharCode(location.codePoint),
      style: TextStyle(
          fontSize: 18,
          fontFamily: location.fontFamily,
          color: highlight ? Colors.red : Colors.black),
      children: [
        TextSpan(
          text: name,
          style: textStyle,
        )
      ],
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final offset = Offset(point.dx, point.dy);
    textPainter.paint(c, offset);
  }
}
