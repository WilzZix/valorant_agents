part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginInProgressState extends AuthState {}

class LoggedInState extends AuthState {
  final UserModel data;

  LoggedInState(this.data);
}

class LoginErrorState extends AuthState {
  final String msg;

  LoginErrorState(this.msg);
}
