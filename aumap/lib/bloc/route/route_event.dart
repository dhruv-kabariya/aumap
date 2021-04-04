part of 'route_bloc.dart';

@immutable
abstract class RouteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RouteCancel extends RouteEvent {}

class SearchRoute extends RouteEvent {
  final LocationPoint start;
  final LocationPoint destination;

  SearchRoute({this.start, this.destination});

  @override
  List<Object> get props => [start, destination];
}
