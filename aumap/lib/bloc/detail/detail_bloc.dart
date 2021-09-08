import 'dart:async';

import 'package:aumap/api/detail.dart';
import 'package:aumap/models/information.dart';
import 'package:aumap/models/location_point.dart';
import 'package:aumap/models/review.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial());

  DetailService service = DetailService();

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is GetLocationDetail) {
      yield LocationDetailFetching();

      List<Review> reviews;
      Information info;
      try {
        reviews = await service.getDetail(event.point);
        info = await service.getInformation(event.point);

        yield LocationDetailFetched(data: info, reviews: reviews);
      } catch (e) {
        print((e.toString()));
        yield LocationDetailFail(e.toString());
      }
    }
    if (event is PostReviewEvent) {
      Review data = await service.postDetail(event.point, event.data);

      yield LocationDetailFetched(
          data: (state as LocationDetailFetched).data,
          reviews: [data] + (state as LocationDetailFetched).reviews);
    }
  }
}
