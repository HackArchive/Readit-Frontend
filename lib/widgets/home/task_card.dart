import 'package:clock_hacks_book_reading/constants/routes.dart';
import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/network/tasks_apis.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:clock_hacks_book_reading/store/user_store.dart';
import 'package:clock_hacks_book_reading/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PropToUpdate {
  isComplete,
  isCanceled,
}

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  onCardTapped(BuildContext context) {
    context.read<TaskStore>().setActiveTask(task);

    Navigator.pushNamed(context, Routes.book);
  }

  onCompleteTapped(
    int id,
    bool isComplete,
    bool isCanceled,
    PropToUpdate propToUpdate,
    BuildContext context,
  ) async {
    final List<Task> tasks = context.read<TaskStore>().userTasks;
    final Task taskToBeUpdated = tasks.firstWhere((_) => _.id == task.id);

    try {
      String token = context.read<UserStore>().currentUser!.token;

      taskToBeUpdated.isCompleted = isComplete;
      taskToBeUpdated.isCanceled = isCanceled;

      // context.read<TaskStore>().setTasks(tasks);

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
      // if (propToUpdate == PropToUpdate.isComplete) {
      //   taskToBeUpdated.isCompleted = !isComplete;
      // } else {
      //   taskToBeUpdated.isCanceled = !isCanceled;
      // }

      // context.read<TaskStore>().setTasks(tasks);

      AppUtils.dismissLoading();
      AppUtils.showToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ListTile(
        onTap: () => onCardTapped(context),
        onLongPress: () {},
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCanceled
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.completed),
        trailing: IconButton(
          onPressed: () {
            onCompleteTapped(
              int.parse(task.id),
              !task.isCompleted,
              task.isCanceled,
              PropToUpdate.isComplete,
              context,
            );
          },
          icon: Icon(
            task.isCompleted
                ? Icons.assignment_turned_in
                : Icons.assignment_turned_in_outlined,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
