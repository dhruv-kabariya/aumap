import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'showdetail_state.dart';

class ShowdetailCubit extends Cubit<ShowdetailState> {
  ShowdetailCubit() : super(ShowdetailInitial());
}
