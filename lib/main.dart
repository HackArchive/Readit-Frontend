import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/pages/login_page.dart';
import 'package:flutter/material.dart';

// flutter packages pub run build_runner build

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Hacks',
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
