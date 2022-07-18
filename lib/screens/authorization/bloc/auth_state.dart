import 'package:firedart/auth/user_gateway.dart';

enum AuthStatus{signedIn, loading, error, signedOut}

class AuthState{

  AuthStatus status;
  User? user;
  String? error;

  AuthState({required this.status, this.user, this.error});

}