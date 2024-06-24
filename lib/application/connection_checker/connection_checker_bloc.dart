import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:volarant_agents/application/connection_checker/connection_checker_event.dart';
import 'package:volarant_agents/application/connection_checker/connection_checker_state.dart';

class ConnectionCheckerBloc
    extends Bloc<ConnectionCheckerEvent, ConnectionCheckerState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectionCheckerBloc() : super(ConnectionCheckerInitial()) {
    // Listen to connectivity changes
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Determine if there is an internet connection
      bool isConnected = result != ConnectivityResult.none;
      // Add the ConnectivityChanged event
      add(ConnectivityChanged(isConnected));
    });
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivitySuccess(event.isConnected));
      } else {
        emit(ConnectivityFailure());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
