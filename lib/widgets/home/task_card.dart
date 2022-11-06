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
  final Function onCompleteTapped;
  final Function onCardTapped;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onCompleteTapped,
    required this.onCardTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ListTile(
        onTap: () => onCardTapped(context, task),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (task.isCanceled) {
                  AppUtils.showToast("Task Already Cancelled");
                  return;
                }

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
                color: Colors.lightGreen,
              ),
            ),
            IconButton(
              onPressed: () {
                if (task.isCanceled) {
                  AppUtils.showToast("Task Already Cancelled");
                  return;
                }

                onCompleteTapped(
                  int.parse(task.id),
                  task.isCompleted,
                  !task.isCanceled,
                  PropToUpdate.isComplete,
                  context,
                );
              },
              icon: Icon(
                task.isCanceled ? Icons.cancel_rounded : Icons.cancel_outlined,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
