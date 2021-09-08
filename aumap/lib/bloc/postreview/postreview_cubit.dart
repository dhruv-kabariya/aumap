import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'postreview_state.dart';

class PostreviewCubit extends Cubit<PostreviewState> {
  PostreviewCubit() : super(PostreviewInitial());

  void setStar(int star) {
    emit(StarSelected(star));
  }

  void showError() {
    emit(ShowError(star_error: "Star must be greater than 1"));
  }
}
