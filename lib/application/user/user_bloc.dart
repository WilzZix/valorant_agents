import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/repositories/user/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      try {
        UserRepository repository = UserRepository();
        emit(CreatingUserState());
        UserModel data =
            await repository.createUser('', event.email, event.password);
        emit(UserCreatedState(data));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(UserCreateFailureState('No user found for that email.'));
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          emit(
              UserCreateFailureState('Wrong password provided for that user.'));
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        emit(UserCreateFailureState(e.toString()));
      }
    });
  }
}
