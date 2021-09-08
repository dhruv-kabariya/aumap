import 'package:aumap/api/likeService.dart';
import 'package:aumap/models/review.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeRemoved());

  final LikeService service = LikeService();

  void checkLike(Review review, String username) async {
    final status = await service.likecheck(review, username);
    if (status) {
      emit(Liked(like: review.total_like));
    } else {
      emit(LikeRemoved(like: review.total_like));
    }
  }

  void toggleLike(Review review, String username, LikeState prevState) async {
    emit(Liking());
    final status = await service.like(review, username);
    if (status) {
      if (prevState is LikeRemoved) {
        review.total_like += 1;
        emit(Liked(like: review.total_like));
      } else {
        review.total_like -= 1;
        emit(LikeRemoved(like: review.total_like));
      }
    } else {
      emit(LikeFail(like: review.total_like));
    }
  }
}
