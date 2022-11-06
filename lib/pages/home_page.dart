import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/network/user_apis.dart';
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
    getProfile(context);
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

  getProfile(BuildContext context) async {
    String token = context.read<UserStore>().currentUser!.token;
    dynamic profileData = await UserAPI.getProfile(token);

    context.read<UserStore>().setUserProfileData(
          profileData["books_completed"],
          profileData["books_pending"],
          profileData["books_canceled"],
        );
  }

  userIconTapped(BuildContext context) {
    Navigator.pushNamed(context, Routes.profile);
  }

  addIconTapped(BuildContext context) {
    Navigator.pushNamed(context, Routes.addBook).then((value) {
      // print(value);
      // if (value == true) {
      getUserTasks(context);
      // }
    });
  }

  onCompleteTapped(
    int id,
    bool isComplete,
    bool isCanceled,
    PropToUpdate propToUpdate,
    BuildContext context,
  ) async {
    final List<Task> tasks = context.read<TaskStore>().userTasks;
    final int taskIndex = tasks.indexWhere((_) => _.id == id.toString());
    final String token = context.read<UserStore>().currentUser!.token;

    Task taskToBeUpdated = Task.fromTask(tasks[taskIndex]);

    try {
      taskToBeUpdated.isCompleted = isComplete;
      taskToBeUpdated.isCanceled = isCanceled;

      tasks[taskIndex] = taskToBeUpdated;

      context.read<TaskStore>().setTasks(tasks.toList());

      bool success = await TaskAPI.updateTask(
        id: id,
        isCompleted: isComplete,
        isCancelled: isCanceled,
        token: token,
      );

      if (!success) {
        throw Exception("Failed to mark complete");
      }

      AppUtils.dismissLoading();
    } catch (e) {
      if (propToUpdate == PropToUpdate.isComplete) {
        taskToBeUpdated.isCompleted = !isComplete;
      } else {
        taskToBeUpdated.isCanceled = !isCanceled;
      }

      tasks[taskIndex] = taskToBeUpdated;
      context.read<TaskStore>().setTasks(tasks.toList());

      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  onCardTapped(BuildContext context, Task task) async {
    context.read<TaskStore>().setActiveTask(task);

    final result = await Navigator.pushNamed(context, Routes.book);

    if (result == true) {
      getUserTasks(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
          child: Observer(
            builder: (BuildContext context) {
              return Column(
                children: context
                    .watch<TaskStore>()
                    .userTasks
                    .map(
                      (task) => TaskCard(
                        task: task,
                        onCompleteTapped: onCompleteTapped,
                        onCardTapped: onCardTapped,
                      ),
                    )
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
      title: const Text("ReadIT"),
      actions: [
        IconButton(
          icon: const Icon(Icons.supervisor_account),
          onPressed: () => userIconTapped(context),
        )
      ],
    );
  }
}
