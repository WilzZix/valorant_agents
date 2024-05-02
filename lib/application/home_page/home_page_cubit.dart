import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/repositories/auth/auth_repository.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  AuthRepository repository = AuthRepository();

  void getUserInfoCubit() async {
    final UserModel data = await repository.getUserInfo();
    emit(UserInfoLoaded(data));
  }
}
