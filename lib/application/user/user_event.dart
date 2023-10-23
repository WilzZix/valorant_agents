part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class CreateUserEvent extends UserEvent {
  final String email;
  final String password;

  CreateUserEvent(this.email, this.password);
}
