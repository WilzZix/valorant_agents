import 'package:volarant_agents/infrastructure/dto/user_model.dart';

abstract class IUser {
  const IUser._();

  Future<UserModel> createUser(String name, String email, String password);
}
