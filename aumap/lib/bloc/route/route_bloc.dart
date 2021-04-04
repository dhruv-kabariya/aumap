import 'dart:async';

import 'package:aumap/api/route.dart';
import 'package:aumap/models/coordinate.dart';
import 'package:aumap/models/location_point.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteInitial());

  RouteService service = RouteService();

  @override
  Stream<RouteState> mapEventToState(
    RouteEvent event,
  ) async* {
    if (event is SearchRoute) {
      yield SearchingRoute();

      yield RouteSearched(
          route: await service.findRoute(event.start, event.destination));
    }
    if (event is RouteCancel) {
      yield RouteInitial();
    }
  }
}
