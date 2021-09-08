part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupWithCred extends SignupEvent {
  final String username;
  final String password;
  final String first_name;
  final String last_name;
  final String email;

  SignupWithCred(this.username, this.password, this.first_name, this.last_name,
      this.email);
}
