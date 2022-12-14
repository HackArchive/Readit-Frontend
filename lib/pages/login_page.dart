// ignore_for_file: unnecessary_const

import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/models/user_model.dart';
import 'package:clock_hacks_book_reading/network/user_apis.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_button.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(
    text: "abc@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "12345678",
  );

  bool isEmailValid = true;
  bool isPasswordValid = true;

  _validateInputFields() {
    setState(() {
      isEmailValid = _emailController.text.trim() != "";
      isPasswordValid = _passwordController.text.length >= 8;
    });
  }

  _loginPressed(BuildContext context) async {
    _validateInputFields();

    if (!isEmailValid || !isPasswordValid) {
      return;
    }

    try {
      AppUtils.showLoading("Logging in..");

      User user =
          await UserAPI.login(_emailController.text, _passwordController.text);

      context.read<UserStore>().login(user);

      AppUtils.dismissLoading();
      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  _registerTapped(BuildContext context) async {
    Navigator.pushNamed(context, Routes.register);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/images/readit_logo.jpeg',
                    scale: 1,
                    key: const Key("login_logo"),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "ReadIT",
                  style: const TextStyle(
                    fontFamily: "assets/fonts/Roboto-Medium.ttf",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff34656d),
                  ),
                  key: Key("login_app_name"),
                )
              ],
            ),
          ),
          LoginTextField(
            key: const Key("Strings.emailFieldKey"),
            controller: _emailController,
            isValid: isEmailValid,
            errorText: "Strings.emailFieldError",
            hintText: "Email",
          ),
          LoginTextField(
            key: const Key("Strings.passwordFieldKey"),
            controller: _passwordController,
            isValid: isPasswordValid,
            errorText: "Strings.passwordFieldError",
            hintText: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 50),
          LoginButton(
            text: "Login",
            onTap: () => _loginPressed(context),
            key: const Key("Strings.loginButtonKey"),
          ),
          const SizedBox(height: 25),
          LoginButton(
            text: "Register",
            onTap: () => _registerTapped(context),
            key: const Key("Strings.registerButtonKey"),
          ),
        ],
      ),
    );
  }
}
