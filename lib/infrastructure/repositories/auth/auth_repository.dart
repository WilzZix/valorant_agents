
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volarant_agents/domain/auth/i_auth.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/services/firebase_service.dart';
import 'package:volarant_agents/infrastructure/services/shared_pref_service.dart';

class AuthRepository implements IAuth {
  SharedPrefService sharedPrefService = SharedPrefService();

  @override
  Future logOut() async {}

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential data = await FireBaseService.auth
        .signInWithEmailAndPassword(email: email, password: password);

    return UserModel(
      email: data.user!.email!,
      displayName: '',
      phoneNumber: '',
      refreshToken: '',
    );
  }

  @override
  Future<void> updateUserDisplayName(String name) async {
    await FireBaseService.auth.currentUser?.updateDisplayName(name);
    sharedPrefService.setDisplayName(name);
  }

  @override
  Future<UserModel> getUserInfo() async {
    UserModel data = UserModel(
      email: FireBaseService.auth.currentUser?.email! ?? '',
      displayName: FireBaseService.auth.currentUser?.displayName! ?? '',
      phoneNumber: '',
      refreshToken: FireBaseService.auth.currentUser?.refreshToken! ?? '',
    );
    return data;
  }
}
