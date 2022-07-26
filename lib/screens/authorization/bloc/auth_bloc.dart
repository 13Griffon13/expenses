import 'package:finances/screens/authorization/bloc/auth_event.dart';
import 'package:finances/screens/authorization/bloc/auth_state.dart';
import 'package:finances/services/firebase_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseServices firebaseServices;

  AuthBloc(AuthState initialState, {required this.firebaseServices})
      : super(initialState) {
    on<AuthSignIn>((event, emit) async {
      try {
        emit(AuthState(status: AuthStatus.loading));
        await firebaseServices.signIn(event.login, event.password).then((user) {
          emit(AuthState(status: AuthStatus.signedIn, user: user));
          return user;
        });
      } catch (exception) {
        emit(AuthState(status: AuthStatus.error, error: exception.toString()));
      }
    });
    on<AuthSignUp>((event, emit) async {
      try {
        emit(AuthState(status: AuthStatus.loading));
        await firebaseServices
            .signUp(event.login, event.password)
            .then((value) {
          emit(AuthState(status: AuthStatus.signedIn));
        });
      } catch (e) {
        emit(AuthState(status: AuthStatus.error, error: e.toString()));
      }
    });
    on<AuthSignOut>((event, emit) async {
      firebaseServices.signOut();
      emit(AuthState(status: AuthStatus.signedOut, user: null));
    });
  }
}
