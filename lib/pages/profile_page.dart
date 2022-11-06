import 'package:clock_hacks_book_reading/models/user_model.dart';
import 'package:clock_hacks_book_reading/network/user_apis.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/widgets/login/login_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  getProfile(String token, BuildContext context) async {
    dynamic profileData = await UserAPI.getProfile(token);

    context.read<UserStore>().setUserProfileData(
          profileData["books_completed"],
          profileData["books_pending"],
          profileData["books_canceled"],
        );
  }

  Column buildCountColumn(int number, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$number',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  onLogout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserStore>().currentUser!;
    getProfile(user.token, context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [],
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
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCountColumn(user.booksPending, "PENDING"),
                  buildCountColumn(user.booksCompleted, "COMPLETED"),
                  buildCountColumn(user.booksCanceled, "CANCELED"),
                ],
              ),
              const SizedBox(height: 40),
              LoginButton(
                text: "LOG OUT",
                onTap: () => onLogout(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
