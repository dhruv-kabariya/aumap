import 'package:aumap/bloc/show_mark/showmark_bloc.dart';
import 'package:aumap/models/location_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationPointRender extends StatelessWidget {
  LocationPointRender({Key key, this.bloc}) : super(key: key);

  final ShowmarkBloc bloc;

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return BlocBuilder(
        bloc: bloc,
        // ignore: missing_return
        builder: (context, state) {
          if (state is HighLightLocation) {
            return CustomPaint(
              painter: Location(location: state.location),
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
  final LocationPoint location;
  Location({this.location});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint();
    location.highlight = true;
    location.markLocation(canvas, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
