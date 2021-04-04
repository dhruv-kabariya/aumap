import 'dart:async';

import 'package:aumap/models/location_point.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'showmark_event.dart';
part 'showmark_state.dart';

class ShowmarkBloc extends Bloc<ShowmarkEvent, ShowmarkState> {
  ShowmarkBloc() : super(ShowmarkInitial());

  @override
  Stream<ShowmarkState> mapEventToState(
    ShowmarkEvent event,
  ) async* {
    if (event is HighLight) {
      yield HighLightLocation(location: event.locationPoint);
    }
    if (event is LocationCancel) {
      yield ShowmarkInitial();
    }
  }
}
