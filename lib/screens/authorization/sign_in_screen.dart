import 'package:finances/screens/authorization/auth_text_field.dart';
import 'package:finances/screens/authorization/sign_up_screen.dart';
import 'package:finances/screens/home_screen/home.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            TextButton(
              onPressed: () async {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return const HomePage();
                }));
              },
              child: const Text("SignIn"),
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SignUpScreen();
                    }));
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
