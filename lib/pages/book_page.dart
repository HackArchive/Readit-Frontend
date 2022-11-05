import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/models/todo_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

enum PropToUpdate {
  isComplete,
  isInProgress,
}

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

  onCompleteTapped(
    int id,
    bool isComplete,
    bool isInProgress,
    PropToUpdate propToUpdate,
    BuildContext context,
  ) async {
    final Task activeTask = context.read<TaskStore>().activeTask!;
    final ToDo targetTodo =
        activeTask.todos.firstWhere((todo) => todo.id == id);

    try {
      String token = context.read<UserStore>().currentUser!.token;

      targetTodo.isCompleted = isComplete;
      targetTodo.isInProgress = isInProgress;

      context.read<TaskStore>().setActiveTask(activeTask);

      bool success = await TaskAPI.updateTodo(
        id: id,
        isCompleted: isComplete,
        isInProgress: isInProgress,
        token: token,
      );

      if (!success) {
        throw Exception("Failed to mark complete");
      }

      AppUtils.dismissLoading();
    } catch (e) {
      if (propToUpdate == PropToUpdate.isComplete) {
        targetTodo.isCompleted = !isComplete;
      } else {
        targetTodo.isInProgress = !isInProgress;
      }

      context.read<TaskStore>().setActiveTask(activeTask);

      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  Widget todoCard(BuildContext context, ToDo todo) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (checked) {
          onCompleteTapped(
            todo.id,
            checked ?? false,
            todo.isInProgress,
            PropToUpdate.isComplete,
            context,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Task? task = context.read<TaskStore>().activeTask;
    getTask(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Page'),
      ),
      body: task == null
          ? const Text('Loading...')
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),
                  Observer(
                    builder: (context) => Column(
                      children: context
                          .watch<TaskStore>()
                          .activeTask!
                          .todos
                          .map((todo) => todoCard(context, todo))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
