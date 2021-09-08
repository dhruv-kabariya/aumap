import 'dart:async';

import 'package:aumap/models/location_point.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../api/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  final SearchService service = SearchService();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchNone) {
      yield SearchInitial();
    }
    if (event is SearchLocation) {
      yield* _mapSearchLocationToState(event);
    } else if (event is LocationDetailsearch) {
      yield* _mapLocationDetailsearchToState(event);
    }
  }

  Stream<SearchState> _mapSearchLocationToState(SearchLocation event) async* {
    yield SeachingLocation();

    yield SearchedLocation(location: await service.searchLocation(event.query));
  }

  Stream<SearchState> _mapLocationDetailsearchToState(
      LocationDetailsearch event) async* {
    yield LocationDetailSearching();
//call api
    // await Future.delayed(Duration(seconds: 2));
    yield LocationDetailSearched(point: event.location);
  }
}
