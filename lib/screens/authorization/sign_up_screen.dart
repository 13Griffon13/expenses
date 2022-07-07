import 'package:finances/screens/authorization/auth_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 48.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Finances'),
            AuthTextField(
                type: AuthFieldType.login,
                controller: loginController,
                name: "Login"),
            AuthTextField(
                type: AuthFieldType.password,
                controller: passwordController,
                name: "Password"),
            AuthTextField(
              type: AuthFieldType.password,
              controller: repeatPasswordController,
              name: "Repeat Password",
            ),
            TextButton(
              onPressed: () async {
                if (passwordController.text == repeatPasswordController.text) {

                } else {

                }
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
