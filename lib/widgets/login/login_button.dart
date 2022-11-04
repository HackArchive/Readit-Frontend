import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onTap;
  final String text;

  const LoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      key: key,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xffa7bbc7),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ),
    );
  }
}
