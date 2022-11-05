import 'package:clock_hacks_book_reading/models/todo_model.dart';

class Task {
  final String id;
  final String title;
  final int durationToCompleteInMinutes;
  final bool isCanceled;
  String completed;
  List<ToDo> todos;
  String userId;

  Task({
    required this.id,
    required this.title,
    this.todos = const [],
    required this.durationToCompleteInMinutes,
    required this.userId,
    required this.isCanceled,
    this.completed = "0%",
  });

  factory Task.getDummyTask({String id = "0"}) {
    return Task(
        id: id,
        title: "Task $id",
        todos: [ToDo.getDummyToDo(), ToDo.getDummyToDo(id: 1)],
        durationToCompleteInMinutes: 60,
        userId: "0",
        isCanceled: false,
        completed: "0.0%");
  }

  factory Task.fromTask(Task task) {
    return Task(
      id: task.id,
      title: task.title,
      durationToCompleteInMinutes: task.durationToCompleteInMinutes,
      userId: task.userId,
      isCanceled: task.isCanceled,
    );
  }

  factory Task.fromJson(var json) {
    return Task(
      id: json['id'].toString(),
      title: json["title"],
      todos: json["todos"] ?? [], // TODO: Parse todos
      durationToCompleteInMinutes: json["duration_in_min"],
      userId: json["userId"] ?? "",
      completed: json["completed"],
      isCanceled: json["is_canceled"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "todos": [], // TODO: Serialize Todos
      "durationToCompleteInMinutes": durationToCompleteInMinutes,
      "userId": userId,
      "is_canceled": isCanceled,
    };
  }
}
