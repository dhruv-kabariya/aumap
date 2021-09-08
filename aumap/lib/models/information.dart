import 'dart:convert';

import 'package:flutter/material.dart';

class Information {
  bool status;
  List<Map<String, dynamic>> data = [];

  Information({this.status, this.data});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data,
    };
  }

  factory Information.fromMap(Map<String, dynamic> map) {
    List data = [];
    for (int i = 0; i < map['data'].length; i++) {}
    return Information(
      status: map['status'],
      data: List<Map<String, dynamic>>.from(
        map['data']?.map(
          (x) {
            return {
              "weekday": WeekDay.values[x["weekday"] - 1],
              "openingtime": TimeOfDay(
                  hour: int.parse((x["openingtime"]).split(":")[0]),
                  minute: int.parse((x["openingtime"]).split(":")[1])),
              "closingtime": TimeOfDay(
                  hour: int.parse((x["closingtime"]).split(":")[0]),
                  minute: int.parse((x["closingtime"]).split(":")[1])),
            };
          },
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Information.fromJson(String source) =>
      Information.fromMap(json.decode(source));
}

enum WeekDay { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
