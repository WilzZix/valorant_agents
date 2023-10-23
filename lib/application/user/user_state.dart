part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class CreatingUserState extends UserState {}

class UserCreatedState extends UserState {
  final UserModel data;

  UserCreatedState(this.data);
}

class UserCreateFailureState extends UserState {
  final String msg;

  UserCreateFailureState(this.msg);
}
