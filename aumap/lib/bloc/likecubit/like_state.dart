part of 'like_cubit.dart';

@immutable
abstract class LikeState extends Equatable {
  @override
  List<Object> get props => [];
}

class Liking extends LikeState {}

class Liked extends LikeState {
  final int like;

  Liked({this.like});
  @override
  List<Object> get props => [like];
}

class LikeRemoved extends LikeState {
  final int like;

  LikeRemoved({this.like});
  @override
  List<Object> get props => [like];
}

class LikeFail extends LikeState {
  final int like;

  LikeFail({this.like});
  @override
  List<Object> get props => [like];
}
