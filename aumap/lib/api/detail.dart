import 'dart:convert';

import 'package:aumap/api/api.dart';
import 'package:aumap/models/information.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/review.dart';

class DetailService {
  Future<List<Review>> getDetail(LocationPoint point) async {
    final String url = 'map/review/' + point.id.toString();

    List<Review> data = [];

    await API.getrequest(url).then((value) {
      List rawdata = jsonDecode(value.body);
      for (int i = 0; i < rawdata.length; i++) {
        data.add(Review.fromMap(rawdata[i]));
      }
    });

    return data;
  }

  Future<Review> postDetail(LocationPoint point, Map review) async {
    final String url = 'map/review/' + point.id.toString();

    Review data;

    await API.postrequest(url, json.encode(review)).then((value) {
      data = Review.fromMap(jsonDecode(value.body));
    });

    return data;
  }

  Future<Information> getInformation(LocationPoint point) async {
    final String url = 'map/information/' + point.id.toString();

    Information data;

    await API.getrequest(url).then((value) {
      data = Information.fromMap(json.decode(value.body));
    });
    return data;
  }
}
