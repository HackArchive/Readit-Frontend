import 'package:clock_hacks_book_reading/models/todo_model.dart';

class Task {
  final String id;
  final String title;
  final List<ToDo> todos;
  final int durationToCompleteInMinutes;
  final String userId;
  String completed;

  Task({
    required this.id,
    required this.title,
    required this.todos,
    required this.durationToCompleteInMinutes,
    required this.userId,
    this.completed = "0%",
  });

  factory Task.getDummyTask({String id = "0"}) {
    return Task(
      id: id,
      title: "Task $id",
      todos: [ToDo.getDummyToDo(), ToDo.getDummyToDo(id: "1")],
      durationToCompleteInMinutes: 60,
      userId: "0",
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "todos": [], // TODO: Serialize Todos
      "durationToCompleteInMinutes": durationToCompleteInMinutes,
      "userId": userId,
    };
  }
}
