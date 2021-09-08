import 'dart:async';

import 'package:aumap/api/authentictionService.dart';
import 'package:aumap/authentication/bloc/authentication_bloc.dart';
import 'package:aumap/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authBloc) : super(LoginInitial());

  AuthenticationService service = AuthenticationService();
  final AuthenticationBloc authBloc;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithCred) {
      User user;
      yield LoginLoading();
      try {
        user = await service.login(event.username, event.password);
        if (user.username == null) {
          yield LoginFail("Invalid Username Or Password");
          authBloc.add(AuthenticationError("Invalid Username Or Password"));
        } else {
          yield LoginDone(user);
          authBloc.add(AuthenticationDone(user));
        }
      } catch (e) {
        print(e.toString());
        yield LoginFail(e.toString());
        authBloc.add(AuthenticationError("Invalid Username Or Password"));
      }
    }
  }
}
