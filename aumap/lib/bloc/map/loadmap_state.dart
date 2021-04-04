part of 'loadmap_cubit.dart';

abstract class LoadmapState extends Equatable {
  const LoadmapState();

  @override
  List<Object> get props => [];
}

class LoadmapInitial extends LoadmapState {}

class Loadingmap extends LoadmapState {}

class LoadedMap extends LoadmapState {
  List<Structural> buidings = [];
  List<Street> streets = [];
  List<LocationPoint> locations;

  LoadedMap(this.buidings, this.streets, this.locations);
}
