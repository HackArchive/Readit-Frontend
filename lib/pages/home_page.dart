import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logout(BuildContext context) {
    // context.read<StudentStore>().logout();
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  addIconTapped(BuildContext context) {
    Navigator.pushNamed(context, Routes.addBook);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: const [
              Text("Home Page"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addIconTapped(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: const Text("Welcome"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(context),
        )
      ],
    );
  }
}
