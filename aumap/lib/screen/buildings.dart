import 'dart:ui';

import 'package:aumap/bloc/map/loadmap_cubit.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/street.dart';

import 'package:aumap/models/structural.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Buildings extends StatelessWidget {
  Buildings({
    Key key,
  }) : super(key: key);

  final LoadmapCubit map = LoadmapCubit()..getMeMap();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: map,
        builder: (context, state) {
          if (state is Loadingmap || state is LoadmapInitial) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadedMap) {
            return CustomPaint(
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              painter: MyMap(state.buidings, state.streets, state.locations),
            );
          }
          return Container();
        });
  }
}

class MyMap extends CustomPainter {
  final List<Structural> buidings;
  final List<Street> streets;
  final List<LocationPoint> locations;

  MyMap(this.buidings, this.streets, this.locations);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey[200], BlendMode.color);

    final Paint p = Paint();
    p.color = Colors.red;
    p.strokeWidth = 1;

    for (int i = 0; i < buidings.length; i++) {
      buidings[i].buildStrucure(canvas, p);
    }

    for (int i = 0; i < streets.length; i++) {
      streets[i].buildStreet(canvas, p);
    }
    for (int i = 0; i < locations.length; i++) {
      locations[i].markLocation(canvas, p);
    }

    // drawseas(canvas, p);
    // drawsas(canvas, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Offset newxy(double x, double y) {
    double nx = ((y - 72.55068) / 0.0043) * 1000;
    double ny = ((x - 23.03864) / -0.00316) * 800;
    return Offset(nx, ny);
  }

  void drawseas(Canvas c, Paint p) {
    Offset tr = newxy(23.036837, 72.551791); //
    Offset tl = newxy(23.037655, 72.551796);
    Offset br = newxy(23.036854, 72.552561);
    Offset bl = newxy(23.037655, 72.552393);
    c.drawLine(tl, tr, p);
    c.drawLine(tr, br, p);
    c.drawLine(br, bl, p);
    c.drawLine(bl, tl, p);
  }

  void drawsas(Canvas c, Paint p) {
    Offset tl = newxy(23.037797, 72.553203); //
    Offset tr = newxy(23.037819, 72.554352);
    Offset br = newxy(23.037565, 72.554357);
    Offset bl = newxy(23.037542, 72.553202);
    List<Offset> points = [tl, tr, br, bl];
    c.drawPoints(PointMode.polygon, points, p);
    c.drawLine(points.last, points.first, p);
    final TextStyle style = TextStyle(color: Colors.black, fontSize: 20);
    final TextSpan text = TextSpan(text: "SAS", style: style);

    final TextPainter paint = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
      // maxLines: 2,
    );
    paint.layout();
    paint.paint(c, newxy(23.037819, 72.554352));
  }
}
