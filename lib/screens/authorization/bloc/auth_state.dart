import 'package:firedart/auth/user_gateway.dart';

enum AuthStatus{init, loading, error, success}

class AuthState{

  AuthStatus status;
  User? user;

  AuthState({required this.status, this.user});

}