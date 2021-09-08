part of 'postreview_cubit.dart';

@immutable
abstract class PostreviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostreviewInitial extends PostreviewState {}

class StarSelected extends PostreviewState {
  final int star;

  StarSelected(this.star);

  @override
  List<Object> get props => [star];
}

class ShowError extends PostreviewState {
  final String star_error;

  ShowError({this.star_error});
  @override
  List<Object> get props => [star_error];
}
