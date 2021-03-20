import 'dart:async';

import 'package:aumap/models/location_point.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchLocation) {
      yield* _mapSearchLocationToState(event);
    } else if (event is FindRoute) {
      yield* _mapFindRouteToState(event);
    }
  }

  Stream<SearchState> _mapSearchLocationToState(SearchLocation event) async* {
    yield SeachingLocation();
    // call api
    yield SearchedLocation(
        location: LocationPoint("SEAS", 0, [23.037819, 72.554352]));
  }

  Stream<SearchState> _mapFindRouteToState(FindRoute event) async* {
    yield FindingRoute();
//call api
    yield FoundRoute();
  }
}
