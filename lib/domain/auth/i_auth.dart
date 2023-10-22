import 'package:firebase_auth/firebase_auth.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';

abstract class IAuth {
  const IAuth._();

  Future<UserModel> login(String email, String password);

  Future logOut();
}
