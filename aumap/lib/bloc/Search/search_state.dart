part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SeachingLocation extends SearchState {}

class SearchedLocation extends SearchState {
  LocationPoint location;
  SearchedLocation({
    @required this.location,
  });
  @override
  List<Object> get props => [location];
}

class NoSearchLocation extends SearchState {}

class FindingRoute extends SearchState {}

class FoundRoute extends SearchState {}
