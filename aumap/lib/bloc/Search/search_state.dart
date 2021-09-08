part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SeachingLocation extends SearchState {}

class SearchedLocation extends SearchState {
  List<LocationPoint> location;
  SearchedLocation({
    @required this.location,
  });
  @override
  List<Object> get props => [location];
}

class LocationDetailSearching extends SearchState {}

class LocationDetailSearched extends SearchState {
  final LocationPoint point;
  LocationDetailSearched({
    @required this.point,
  });
  @override
  List<Object> get props => [point];
}
