class ToDo {
  final int id;
  final String title;
  final bool isCompleted;
  final bool isInProgress;
  final String taskId;

  ToDo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.isInProgress,
    this.taskId = "",
  });

  factory ToDo.getDummyToDo({int id = 0, String taskId = "0"}) {
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
      isCompleted: json["is_completed"],
      isInProgress: json["is_inprogress"],
      taskId: json["taskId"] ?? "",
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
