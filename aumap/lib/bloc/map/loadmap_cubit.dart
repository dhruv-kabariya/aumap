import 'package:aumap/api/structure_service.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/street.dart';
import 'package:aumap/models/structural.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loadmap_state.dart';

class LoadmapCubit extends Cubit<LoadmapState> {
  LoadmapCubit() : super(LoadmapInitial());

  final S_Service service = S_Service();

  List<Structural> buidings = [];
  List<Street> streets = [];
  List<LocationPoint> locations = [];

  void getMeMap() async {
    emit(Loadingmap());

    Map data = await service.getMapData();
    buidings = data["buildings"];
    streets = data["streets"];
    locations = data["locations"];

    emit(LoadedMap(buidings, streets, locations));
  }
}
