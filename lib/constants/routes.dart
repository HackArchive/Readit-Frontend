import 'package:clock_hacks_book_reading/pages/add_book_page.dart';
import 'package:clock_hacks_book_reading/pages/book_page.dart';
import 'package:clock_hacks_book_reading/pages/home_page.dart';
import 'package:clock_hacks_book_reading/pages/login_page.dart';
import 'package:clock_hacks_book_reading/pages/profile_page.dart';
import 'package:clock_hacks_book_reading/pages/register_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  // static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addBook = '/addBook';
  static const String book = '/book';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    // splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => const LoginPage(),
    register: (BuildContext context) => const RegisterPage(),
    home: (BuildContext context) => const HomePage(),
    addBook: (BuildContext context) => const AddBookPage(),
    book: (BuildContext context) => BookPage(),
    profile: (BuildContext context) => const ProfilePage(),
  };
}
