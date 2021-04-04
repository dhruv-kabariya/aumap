part of 'route_bloc.dart';

@immutable
abstract class RouteState extends Equatable {
  @override
  List<Object> get props => [];
}

class RouteInitial extends RouteState {}

class SearchingRoute extends RouteState {}

class RouteSearched extends RouteState {
  final List<Coordinate> route;

  RouteSearched({this.route}) {}
  @override
  List<Object> get props => [route];
}
