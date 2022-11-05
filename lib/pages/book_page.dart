import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/store/task_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Task? task = context.read<TaskStore>().activeTask;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: task == null ? const Text('Loading') : Text(task.title),
      ),
    );
  }
}
