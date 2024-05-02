import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:volarant_agents/domain/auth/i_auth.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/services/firebase_service.dart';

class AuthRepository implements IAuth {
  @override
  Future logOut() async {}

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential data = await FireBaseService.auth
        .signInWithEmailAndPassword(email: email, password: password);
    log('line 18 $data');
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
