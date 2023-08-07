part of 'app_manager_cubit.dart';

@immutable
abstract class AppManagerState {}

class AppManagerInitial extends AppManagerState {}

class AppManagerLoading extends AppManagerState {}

class AppManagerLoaded extends AppManagerState {}
