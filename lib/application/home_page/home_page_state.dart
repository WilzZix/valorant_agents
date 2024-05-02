part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class UserInfoLoaded extends HomePageState {
  final UserModel userDate;

  UserInfoLoaded(this.userDate);
}
