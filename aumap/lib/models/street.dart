import 'package:aumap/models/converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Street {
  int id;
  Offset start;
  Offset end;
  String name;
  bool highlight;

  Street(this.id, this.name, this.start, this.end, this.highlight);

  Street.fromJson(Map json) {
    this.id = json["id"];
    this.name = json["name"];
    this.start = newxy(json["start"][0], json["start"][1]);
    this.end = newxy(json["end"][0], json["end"][1]);

    this.highlight = false;
  }

  void buildStreet(Canvas c, Paint p) {
    p.color = Colors.grey;
    p.strokeWidth = 10;
    c.drawLine(this.start, this.end, p);
  }
}
