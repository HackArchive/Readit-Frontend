import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/network/user_apis.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_button.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController(
    text: "John Doe",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "abc@gmail.com",
  );
  final TextEditingController _phoneController = TextEditingController(
    text: "+910000000000",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "12345678",
  );

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPhoneValid = true;
  bool isPasswordValid = true;

  _validateInputFields() {
    setState(() {
      isNameValid = _nameController.text.trim() != "";
      isEmailValid = _emailController.text.trim() != "";
      isPhoneValid = _phoneController.text.length == 13;
      isPasswordValid = _passwordController.text.length >= 8;
    });
  }

  _registerPresses(BuildContext context) async {
    _validateInputFields();

    if (!isNameValid || !isEmailValid || !isPhoneValid || !isPasswordValid) {
      return;
    }

    try {
      AppUtils.showLoading("Registering...");

      bool registrationSuccessful = await UserAPI.register(
        _nameController.text,
        _phoneController.text,
        _emailController.text,
        _passwordController.text,
      );

      if (!registrationSuccessful) {
        throw Exception("Failed to register, please try again later");
      }

      // If login successful, redirect
      AppUtils.dismissLoading();
      Navigator.pop(context);
    } catch (e) {
      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  _loginTapped(BuildContext context) async {
    Navigator.pop(context, Routes.login);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                  style: TextStyle(
                    fontFamily: "assets/fonts/Roboto-Medium.ttf",
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff34656d),
                  ),
                  key: Key("login_app_name"),
                )
              ],
            ),
          ),
          LoginTextField(
            controller: _nameController,
            isValid: isNameValid,
            errorText: "Strings.nameError",
            hintText: "Name",
          ),
          LoginTextField(
            key: const Key("Strings.emailFieldKey"),
            controller: _emailController,
            isValid: isEmailValid,
            errorText: "Strings.emailFieldError",
            hintText: "Email",
          ),
          LoginTextField(
            key: const Key("Strings.phoneFieldKey"),
            controller: _phoneController,
            isValid: isPhoneValid,
            errorText: "Strings.phoneFieldError",
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
            text: "Register",
            onTap: () => _registerPresses(context),
            key: const Key("Strings.loginButtonKey"),
          ),
          const SizedBox(height: 25),
          LoginButton(
            text: "Back",
            onTap: () => _loginTapped(context),
            key: const Key("Strings.registerButtonKey"),
          ),
        ],
      ),
    );
  }
}
