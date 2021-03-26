import 'package:aumap/models/converter.dart';
import 'package:flutter/material.dart';

class LocationPointRender extends StatelessWidget {
  const LocationPointRender({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Location(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
      ),
    );
  }
}

class Location extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint();
    p.color = Colors.pink;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
