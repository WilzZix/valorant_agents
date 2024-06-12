import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/services/network_provider.dart';

part 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  Future<void> initApp() async {
    emit(AppManagerInitial());
    try {
      log('line 15 initApp');
      await NetworkProvider.init();
      log('line 17 initApp');
      emit(AppManagerLoaded());
      log('line 19 initApp');
    } catch (e) {
      emit(AppManagerLoadingError(msg: e.toString()));
    }
  }
}
