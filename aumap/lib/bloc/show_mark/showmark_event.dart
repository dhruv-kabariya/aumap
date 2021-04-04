part of 'showmark_bloc.dart';

@immutable
abstract class ShowmarkEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HighLight extends ShowmarkEvent {
  final LocationPoint locationPoint;

  HighLight({this.locationPoint});

  @override
  List<Object> get props => [locationPoint];
}

class LocationCancel extends ShowmarkEvent {}
