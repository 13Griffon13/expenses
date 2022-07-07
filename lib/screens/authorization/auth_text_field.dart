import 'package:flutter/material.dart';

enum AuthFieldType { login, password }

class AuthTextField extends StatelessWidget {
  final AuthFieldType type;
  final String name;
  final TextEditingController controller;

  const AuthTextField(
      {Key? key,
      required this.type,
      required this.controller,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 2.0,),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blueGrey,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: 36.0,
            child: TextField(
              controller: controller,
              obscureText: type == AuthFieldType.password,
              maxLines: 1,
              decoration: const InputDecoration(
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        Positioned(
          left: 30.0,
          top: 0.0,
          child: Container(
            color: Colors.white,
            child: Text(
              name,
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
