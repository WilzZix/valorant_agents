import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:volarant_agents/domain/auth/i_auth.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/services/firebase_service.dart';

class AuthRepository implements IAuth {
  final FireBaseService authService = FireBaseService();

  @override
  Future logOut() async {}

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential data = await authService.auth
        .signInWithEmailAndPassword(email: email, password: password);
    log('line 18 $data');
    return UserModel(
      data.user!.email!,
      '',
      '',
      '',
    );
  }
}
