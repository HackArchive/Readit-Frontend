class ToDo {
  final String id;
  final String title;
  final bool isCompleted;
  final bool isInProgress;
  final String taskId;

  ToDo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isInProgress,
    required this.taskId,
  });

  factory ToDo.getDummyToDo({String id = "0", String taskId = "0"}) {
    return ToDo(
      id: id,
      title: "Todo $id",
      isCompleted: false,
      isInProgress: true,
      taskId: taskId,
    );
  }

  factory ToDo.fromJson(var json) {
    return ToDo(
      id: json['id'],
      title: json["title"],
      isCompleted: json["isComplete"],
      isInProgress: json["isInProgress"],
      taskId: json["taskId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "isCompleted": isCompleted,
      "isInProgress": isInProgress,
      "taskId": taskId,
    };
  }
}
