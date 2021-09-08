import 'dart:async';

import 'package:aumap/api/authentictionService.dart';
import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this.authBloc) : super(SignupInitial());

  final AuthenticationBloc authBloc;
  final AuthenticationService service = AuthenticationService();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignupWithCred) {
      yield SignupLoading();
      try {
        User user = await service.signUp(
          event.username,
          event.first_name,
          event.last_name,
          event.email,
          event.password,
        );
        yield SignupDone(user);
        authBloc.add(AuthenticationDone(user));
      } catch (e) {
        yield SignupFail(e.toString());
        authBloc.add(AuthenticationError(e.toString()));
      }
    }
  }
}
