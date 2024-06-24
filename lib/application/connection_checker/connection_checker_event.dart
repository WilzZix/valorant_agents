import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ConnectionCheckerEvent extends Equatable {
  const ConnectionCheckerEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectionCheckerEvent {
  final bool isConnected;

  const ConnectivityChanged(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}
