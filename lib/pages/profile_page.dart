import 'package:clock_hacks_book_reading/models/user_model.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserStore>().currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                child: Text(
                  user.name.characters.first,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
