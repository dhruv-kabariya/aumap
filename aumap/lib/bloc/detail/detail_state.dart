part of 'detail_bloc.dart';

@immutable
abstract class DetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class LocationDetailFetching extends DetailState {}

class LocationDetailFetched extends DetailState {
  final Information data;
  final List<Review> reviews;

  LocationDetailFetched({this.data, this.reviews});

  @override
  List<Object> get props => [data, reviews];
}

class LocationDetailFail extends DetailState {
  final String error;

  LocationDetailFail(this.error);
  @override
  List<Object> get props => [error];
}
