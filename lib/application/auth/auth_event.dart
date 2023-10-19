part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent(this.email, this.password);
}

class RegisterWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  RegisterWithEmailAndPassword(this.email, this.password);
}
