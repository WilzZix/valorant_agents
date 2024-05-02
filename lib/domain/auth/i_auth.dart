import 'package:volarant_agents/infrastructure/dto/user_model.dart';

abstract class IAuth {
  const IAuth._();

  Future<UserModel> login(String email, String password);

  Future logOut();

  Future<void> updateUserDisplayName(String name);

  Future<UserModel> getUserInfo();
}
