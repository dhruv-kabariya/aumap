import 'package:aumap/screen/buildings.dart';
import 'package:aumap/screen/locationpointrender.dart';
import 'package:aumap/screen/routerender.dart';
import 'package:flutter/material.dart';

class MapRender extends StatelessWidget {
  const MapRender({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 10,
      panEnabled: true,
      scaleEnabled: true,
      child: Stack(
        children: [
          Buildings(),
          // RouteRender(),
          LocationPointRender()
        ],
      ),
    );
  }
}
