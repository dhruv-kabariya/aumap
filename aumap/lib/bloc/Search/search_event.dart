part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchNone extends SearchEvent {}

class SearchLocation extends SearchEvent {
  final String query;
  SearchLocation({
    @required this.query,
  });

  @override
  List<Object> get props => [query];
}

class LocationDetailsearch extends SearchEvent {
  final LocationPoint location;

  LocationDetailsearch({
    @required this.location,
  });

  @override
  List<Object> get props => [location];
}
