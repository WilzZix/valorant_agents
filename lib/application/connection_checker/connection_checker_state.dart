import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ConnectionCheckerState extends Equatable {}

final class ConnectionCheckerInitial extends ConnectionCheckerState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// State when connectivity check is successful
class ConnectivitySuccess extends ConnectionCheckerState {
  final bool isConnected;

  ConnectivitySuccess(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}

// State when there is no connectivity
class ConnectivityFailure extends ConnectionCheckerState {
  @override
  List<Object> get props => [];
}
