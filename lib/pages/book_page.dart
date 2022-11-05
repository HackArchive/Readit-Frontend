import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/models/todo_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  getTask(BuildContext context) async {
    try {
      AppUtils.showLoading("Loading todos...");

      String token = context.read<UserStore>().currentUser!.token;
      final Task? task = context.read<TaskStore>().activeTask;

      List<ToDo> todos = await TaskAPI.getTodoItems(task!.id, token);
      task.todos = todos;

      context.read<TaskStore>().setActiveTask(task);

      AppUtils.dismissLoading();
    } catch (e) {
      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Task? task = context.read<TaskStore>().activeTask;
    getTask(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Page'),
      ),
      body: Observer(
        builder: (context) => Container(
          padding: const EdgeInsets.all(0),
          child: task == null
              ? const Text('Loading')
              : Text(
                  task.todos.length.toString(),
                ),
        ),
      ),
    );
  }
}
