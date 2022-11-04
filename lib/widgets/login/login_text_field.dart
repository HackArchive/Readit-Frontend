import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isValid;
  final String errorText;
  final String hintText;
  final bool obscureText;

  const LoginTextField({
    Key? key,
    required this.controller,
    required this.isValid,
    required this.errorText,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        bottom: 10.0,
      ),
      child: TextField(
        key: key,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: isValid ? null : errorText,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
