part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationLogin extends AuthenticationState {}

class AuthenticationSignUp extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  final String error;

  AuthenticationFail(this.error);
  @override
  List<Object> get props => [error];
}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  AuthenticationSuccess({this.user});
  @override
  List<Object> get props => [user];
}
