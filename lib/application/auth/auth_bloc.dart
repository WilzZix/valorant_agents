import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/repositories/auth/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      try {
        AuthRepository repository = AuthRepository();
        emit(LoginInProgressState());
        UserModel data = await repository.login(event.email, event.password);
        emit(LoggedInState(data));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginErrorState('No user found for that email.'));
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          emit(LoginErrorState('Wrong password provided for that user.'));
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        log('line 39');
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
