import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/services/network_provider.dart';

part 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  Future<void> initApp() async {
    emit(AppManagerInitial());
    try {
      await NetworkProvider.init();
      emit(AppManagerLoaded());
    } catch (e) {
      print("line 19: $e");
    }
  }
}
