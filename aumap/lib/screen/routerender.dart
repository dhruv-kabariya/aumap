import 'dart:ui';

import 'package:aumap/bloc/route/route_bloc.dart';
import 'package:aumap/models/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteRender extends StatelessWidget {
  RouteRender({Key key, this.bloc}) : super(key: key);

  final RouteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is RouteSearched) {
            return CustomPaint(
              painter: Location(route: state.route),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            );
          } else {
            return Container(
              color: Colors.transparent,
            );
          }
        });
  }
}

class Location extends CustomPainter {
  final List<Coordinate> route;
  Location({this.route});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint();
    p.color = Colors.lightBlueAccent;
    p.strokeWidth = 8;
    p.strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, route.map((e) => e.point).toList(), p);
    // canvas.drawLine(route.last.point, route.first.point, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
