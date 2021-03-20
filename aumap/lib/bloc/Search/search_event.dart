part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchLocation extends SearchEvent {
  String query;
  SearchLocation({
    @required this.query,
  });

  @override
  List<Object> get props => [query];
}

class FindRoute extends SearchEvent {
  String startLocation;
  String endLocation;
  FindRoute({
    @required this.startLocation,
    @required this.endLocation,
  });

  @override
  List<Object> get props => [startLocation, endLocation];
}
