import 'package:aumap/bloc/route/route_bloc.dart';
import 'package:aumap/bloc/show_mark/showmark_bloc.dart';
import 'package:aumap/screen/buildings.dart';
import 'package:aumap/screen/locationpointrender.dart';
import 'package:aumap/screen/routerender.dart';
import 'package:flutter/material.dart';

class MapRender extends StatelessWidget {
  const MapRender({Key key, this.bloc, this.route}) : super(key: key);
  final ShowmarkBloc bloc;
  final RouteBloc route;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 10,
      panEnabled: true,
      scaleEnabled: true,
      boundaryMargin: EdgeInsets.all(100),
      child: Stack(
        children: [
          Buildings(),
          RouteRender(
            bloc: route,
          ),
          LocationPointRender(
            bloc: bloc,
          )
        ],
      ),
    );
  }
}
