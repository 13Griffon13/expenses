abstract class AuthEvent{

}

abstract class AuthEntryEvent extends AuthEvent{
  final String login;
  final String password;

  AuthEntryEvent(this.login, this.password);
}

class AuthSignOut extends AuthEvent{

}

class AuthSignIn extends AuthEntryEvent{
  AuthSignIn(String login, String password) : super(login, password);

}

class AuthSignUp extends AuthEntryEvent{
  AuthSignUp(String login, String password) : super(login, password);

}
