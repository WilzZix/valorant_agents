import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/repositories/auth/auth_repository.dart';
import 'package:volarant_agents/infrastructure/services/shared_pref_service.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  AuthRepository repository = AuthRepository();
  SharedPrefService sharedPrefService = SharedPrefService();

  void getUserInfoCubit() async {
    final UserModel data = await repository.getUserInfo();

    emit(UserInfoLoaded(
        userDate: data, displayName: await sharedPrefService.getDisplayName()));
  }
}
