part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetLocationDetail extends DetailEvent {
  final LocationPoint point;

  GetLocationDetail(this.point);

  @override
  List<Object> get props => [point];
}

class PostReviewEvent extends DetailEvent {
  final LocationPoint point;
  final Map<String, dynamic> data;

  PostReviewEvent(this.point, this.data);
  @override
  List<Object> get props => [point, data];
}
