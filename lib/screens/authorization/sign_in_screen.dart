import 'package:finances/screens/authorization/auth_text_field.dart';
import 'package:finances/screens/authorization/bloc/auth_bloc.dart';
import 'package:finances/screens/authorization/bloc/auth_event.dart';
import 'package:finances/screens/authorization/bloc/auth_state.dart';
import 'package:finances/screens/authorization/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //todo probably should revisit this screen
    var state = BlocProvider.of<AuthBloc>(context).state;
    return Scaffold(
      body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Finances"),
                  AuthTextField(
                      type: AuthFieldType.login,
                      controller: loginController,
                      name: "Login"),
                  AuthTextField(
                      type: AuthFieldType.password,
                      controller: passwordController,
                      name: "Password"),
                  if(state.status != AuthStatus.loading)
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(AuthSignIn(
                            loginController.text, passwordController.text));
                      },
                      child: const Text("SignIn"),
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (state.status == AuthStatus.error)
                    Text(
                      state.error ?? "Unhandled error",
                      style: const TextStyle(color: Colors.red),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have a account?"),
                      TextButton(
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return SignUpScreen();
                            }),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
