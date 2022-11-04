import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController(
    text: "9191919191",
  );
  final TextEditingController _idController = TextEditingController(
    text: "0123456789",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "12345678",
  );

  bool isPhoneValid = true;
  bool isIdValid = true;
  bool isPasswordValid = true;

  _validateInputFields() {
    setState(() {
      isPhoneValid = _passwordController.text.length == 10;
      isIdValid = _idController.text.length == 10;
      isPasswordValid = _passwordController.text.length >= 8;
    });
  }

  _loginPressed(BuildContext context) async {
    _validateInputFields();

    if (!isIdValid || !isPasswordValid) {
      return;
    }

    try {
      // AppUtils.showLoading("Logging in..");
      // Student student = await StudentApi.login(
      //   _idController.text,
      //   _passwordController.text,
      // );

      // context.read<StudentStore>().login(student);
      // context
      //     .read<AssignedExamStore>()
      //     .getAssignedExams(student.id, student.token);

      // AppUtils.dismissLoading();

      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      // AppUtils.dismissLoading();
      // AppUtils.showToast(e.toString());
    }
  }

  @override
  void dispose() {
    _idController.dispose();
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
              children: const [
                // Image.asset(
                //   'assets/images/logo.png',
                //   scale: 3,
                //   key: const Key("login_logo"),
                // ),
                SizedBox(height: 10),
                Text(
                  "BOOK APP",
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
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              bottom: 10.0,
            ),
            child: TextField(
              key: const Key("Strings.phoneFieldKey"),
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "ID",
                errorText: isPhoneValid ? null : "Strings.phoneFieldError",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              bottom: 10.0,
            ),
            child: TextField(
              key: const Key("Strings.idFieldKey"),
              controller: _idController,
              decoration: InputDecoration(
                hintText: "ID",
                errorText: isIdValid ? null : "Strings.idFieldError",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextField(
              key: const Key("Strings.passwordFieldKey"),
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                errorText:
                    isPasswordValid ? null : "Strings.passwordFieldError",
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () => _loginPressed(context),
            key: const Key("Strings.loginButtonKey"),
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: const Color(0xffa7bbc7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
