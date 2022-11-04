import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/pages/login_page.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

// flutter packages pub run build_runner build

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final UserStore _userStore = UserStore();
  final TaskStore _taskStore = TaskStore();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => _userStore),
        Provider(create: (_) => _taskStore),
      ],
      child: MaterialApp(
        title: 'Clock Hacks',
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
