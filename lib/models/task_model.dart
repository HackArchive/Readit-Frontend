import 'package:clock_hacks_book_reading/models/todo_model.dart';

class Task {
  final String id;
  final String title;
  final List<ToDo> todos;
  final int durationToCompleteInMinutes;
  final String userId;

  Task({
    required this.id,
    required this.title,
    required this.todos,
    required this.durationToCompleteInMinutes,
    required this.userId,
  });

  factory Task.getDummyTask() {
    return Task(
      id: "0",
      title: "Task 0",
      todos: [ToDo.getDummyToDo(), ToDo.getDummyToDo(id: "1")],
      durationToCompleteInMinutes: 60,
      userId: "0",
    );
  }

  factory Task.fromJson(var json) {
    return Task(
      id: json['id'],
      title: json["title"],
      todos: json["todos"], // TODO: Parse todos
      durationToCompleteInMinutes: json["durationToCompleteInMinutes"],
      userId: json["userId"],
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
