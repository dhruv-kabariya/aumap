part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginDone extends LoginState {
  final User user;

  LoginDone(this.user);
}

class LoginFail extends LoginState {
  final String error;

  LoginFail(this.error);
}
