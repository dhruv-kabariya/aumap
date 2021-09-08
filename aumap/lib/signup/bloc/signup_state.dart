part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupDone extends SignupState {
  final User user;

  SignupDone(this.user);
}

class SignupFail extends SignupState {
  final String error;

  SignupFail(this.error);
}
