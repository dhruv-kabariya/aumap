import 'package:aumap/models/location_point.dart';
import 'package:aumap/screen/locationpointrender.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'search_route_state.dart';

class SearchRouteCubit extends Cubit<SearchRouteState> {
  SearchRouteCubit() : super(SearchRouteInitial());

  void search(
      // {LocationPoint point}
      ) {
    emit(SearchRouteInitial());
  }

  void route() {
    emit(RouteSearch());
  }
}
