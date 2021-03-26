import 'package:aumap/api/locationpointService.dart';
import 'package:aumap/api/streetservice.dart';
import 'package:aumap/api/structure_service.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/street.dart';
import 'package:aumap/models/structural.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loadmap_state.dart';

class LoadmapCubit extends Cubit<LoadmapState> {
  LoadmapCubit() : super(LoadmapInitial());

  final BuildingService service = BuildingService();
  final StreetService streetService = StreetService();
  final LocationPointService locationService = LocationPointService();

  List<Structural> buidings = [];
  List<Street> streets = [];
  List<LocationPoint> locations = [];

  void getMeMap() async {
    emit(Loadingmap());

    buidings = await service.getBuilldingData();
    streets = await streetService.getStreetData();
    locations = await locationService.getLocationPointData();

    emit(LoadedMap(buidings, streets, locations));
  }
}
