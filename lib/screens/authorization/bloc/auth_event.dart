abstract class AuthEvent{
  final String login;
  final String password;

  AuthEvent(this.login, this.password);
}

class AuthSignIn extends AuthEvent{
  AuthSignIn(String login, String password) : super(login, password);

}

class AuthSignUp extends AuthEvent{
  AuthSignUp(String login, String password) : super(login, password);

}
