import 'package:aumap/api/api.dart';
import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LocationPoint {
  int id;
  String name;
  Offset point;
  String website;
  String desciption;
  Map<String, String> marker;
  bool highlight = false;
  List<String> pictures = [];
  int phone;
  double avg_star;
  int no_of_review;

  LocationPoint(this.id, this.name, this.point, this.desciption, this.marker,
      this.website);

  LocationPoint.fromJson(Map json) {
    // print(API.url.substring(0, API.url.length - 1));
    this.id = json["id"];
    this.name = json["p_name"];
    this.point = newxy(json["point"]["latitude"], json["point"]["longitude"]);
    this.website = json["website"];
    this.desciption = json["desciption"];
    this.phone = json["phone"];
    this.marker = {
      "icon": json["marker"]["icon"],
      "color": json["marker"]["color"],
    };
    this.avg_star = json["avg_star"];
    this.no_of_review = json["no_of_review"];
    for (int i = 0; i < json["location_pic"].length; i++) {
      this.pictures.add(API.url.substring(0, API.url.length - 1) +
          json["location_pic"][i]["file_name"]);
    }
  }

  final Map<String, IconData> mapper = {
    "garden": Icons.park,
    "school": Icons.school_sharp,
    "gate": Icons.location_on_rounded,
    "ground": Icons.sports_basketball_sharp
  };

  final Map<String, Color> c_mapper = {
    "garden": Color(0xFF006400),
    "school": Color(0xFF8B0000),
    "gate": Color(0xFF191970),
    "ground": Color(0xFF000000)
  };

  void markLocation(Canvas c, Paint p) {
    final location = this.mapper[marker["icon"]];

    final textStyle = GoogleFonts.lato(
        fontSize: 13, color: highlight ? Colors.red : c_mapper[marker["icon"]]);
    final textSpan = TextSpan(
      text: String.fromCharCode(location.codePoint),
      style: TextStyle(
          fontSize: 18,
          fontFamily: location.fontFamily,
          color: highlight ? Colors.red : c_mapper[marker["icon"]]),
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
