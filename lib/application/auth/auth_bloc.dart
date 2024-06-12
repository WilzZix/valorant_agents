import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:volarant_agents/infrastructure/dto/user_model.dart';
import 'package:volarant_agents/infrastructure/repositories/auth/auth_repository.dart';
import 'package:volarant_agents/infrastructure/services/shared_pref_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    AuthRepository repository = AuthRepository();
    SharedPrefService sharedPrefService = SharedPrefService();
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      try {
        emit(LoginInProgressState());

        UserModel data = await repository.login(event.email, event.password);
        await sharedPrefService.setLoginState(true);
        emit(LoggedInState(data));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(LoginErrorState('No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          emit(LoginErrorState('Wrong password provided for that user.'));
        }
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
    on<UpdateUserNameEvent>((event, emit) async {
      try {
        await repository.updateUserDisplayName(event.name);
        emit(UserDisplayNameUpdated());
      } catch (e) {
        emit(UserDisplayNameUpdatingError(e.toString()));
      }
    });
  }
}
