import 'dart:async';

import 'package:aumap/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationLogin());

  static User user;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationLoginForm) {
      yield AuthenticationLogin();
    } else if (event is AuthenticationSignUpForm) {
      yield AuthenticationSignUp();
    } else if (event is AuthenticationError) {
      yield AuthenticationFail(event.error);
    } else if (event is AuthenticationDone) {
      user = event.user;
      yield AuthenticationSuccess(user: event.user);
    }
  }
}
