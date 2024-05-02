import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:volarant_agents/domain/user/i_user.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/services/firebase_service.dart';

class UserRepository implements IUser {
  @override
  Future<UserModel> createUser(
      String name, String email, String password) async {
    UserCredential data = await FireBaseService.auth
        .createUserWithEmailAndPassword(email: email, password: password);
    log('line 14 $data');
    return UserModel(
      email: data.user!.email!,
      phoneNumber: '',
      refreshToken: '',
      displayName: '',
    );
  }
}
