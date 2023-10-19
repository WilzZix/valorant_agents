import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      try {
        emit(LoginInProgressState());
        UserModel data = UserModel('', '', '', '');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password)
            .then((value) {
          data = UserModel(
              value.user!.email.toString(),
              value.user!.displayName.toString(),
              value.user!.phoneNumber.toString(),
              value.user!.refreshToken.toString());
          log('line 28 $value');
          emit(LoggedInState(data));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginErrorState('No user found for that email.'));
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          emit(LoginErrorState('Wrong password provided for that user.'));
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
