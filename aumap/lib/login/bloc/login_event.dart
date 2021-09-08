part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithCred extends LoginEvent {
  final String username;
  final String password;

  LoginWithCred(this.username, this.password);
}
