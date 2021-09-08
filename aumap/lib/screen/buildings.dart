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
    final Paint p = Paint();

    for (int i = 0; i < buidings.length; i++) {
      buidings[i].buildStrucure(canvas, p);
    }

    for (int i = 0; i < streets.length; i++) {
      streets[i].buildStreet(canvas, p);
    }

    for (int i = 0; i < locations.length; i++) {
      locations[i].markLocation(canvas, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
