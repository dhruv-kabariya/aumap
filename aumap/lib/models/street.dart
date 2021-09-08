import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Street {
  Offset start;
  Offset end;
  String name;
  double lenght;
  bool highlight;

  Street(this.name, this.start, this.end, this.lenght, this.highlight);

  Street.fromJson(Map json) {
    this.name = json["name"];
    this.start = newxy(json["start"]["latitude"], json["start"]["longitude"]);
    this.end = newxy(json["end"]["latitude"], json["end"]["longitude"]);

    this.highlight = false;
  }

  void buildStreet(Canvas c, Paint p) {
    p.color = Colors.grey;
    p.strokeWidth = 8;
    p.strokeCap = StrokeCap.round;
    c.drawLine(this.start, this.end, p);
  }
}
