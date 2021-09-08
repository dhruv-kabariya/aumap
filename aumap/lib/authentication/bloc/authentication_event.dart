part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLoginForm extends AuthenticationEvent {}

class AuthenticationSignUpForm extends AuthenticationEvent {}

class AuthenticationError extends AuthenticationEvent {
  final String error;

  AuthenticationError(this.error);
  @override
  List<Object> get props => [error];
}

class AuthenticationDone extends AuthenticationEvent {
  final User user;

  AuthenticationDone(this.user);

  @override
  List<Object> get props => [user];
}
