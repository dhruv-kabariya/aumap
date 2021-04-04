part of 'showmark_bloc.dart';

@immutable
abstract class ShowmarkState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShowmarkInitial extends ShowmarkState {}

class HighLightLocation extends ShowmarkState {
  final LocationPoint location;

  HighLightLocation({this.location});
  @override
  List<Object> get props => [location];
}
