import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:clock_hacks_book_reading/widgets/home/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUserTasks(context);
  }

  getUserTasks(BuildContext context) async {
    try {
      AppUtils.showLoading("Loading tasks...");

      String token = context.read<UserStore>().currentUser!.token;
      List<Task> tasks = await TaskAPI.getAllTask(token);

      context.read<TaskStore>().setTasks(tasks);

      AppUtils.dismissLoading();
    } catch (e) {
      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  logout(BuildContext context) {
    context.read<UserStore>().logout();
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  addIconTapped(BuildContext context) {
    Navigator.pushNamed(context, Routes.addBook).then((value) {
      // print(value);
      // if (value == true) {
      getUserTasks(context);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Observer(
            builder: (BuildContext context) {
              return Column(
                children: context
                    .watch<TaskStore>()
                    .userTasks
                    .map((task) => TaskCard(task: task))
                    .toList(),
              );
            },
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
      title: const Text("ReatIT"),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(context),
        )
      ],
    );
  }
}
