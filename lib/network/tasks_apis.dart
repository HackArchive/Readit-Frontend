// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:clock_hacks_book_reading/models/todo_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:clock_hacks_book_reading/constants/api_endpoints.dart';
import 'package:image_picker/image_picker.dart';

// TODO: Replace dummpy data with serialized objects

class TaskAPI {
  static Future<bool> createTask(
    String token,
    String title,
    int duration,
    String durationType,
    List<XFile> files, {
    List<String> exclude = const [],
  }) async {
    final String data = jsonEncode({
      "title": title,
      "duration_type": durationType,
      "duration": duration,
      "exclude": exclude.toString(),
    });

    final formData = dio.FormData();
    final mapData = MapEntry("data", data);
    formData.fields.add(mapData);

    for (var file in files) {
      final multipartFile = dio.MultipartFile.fromFileSync(file.path);
      final imageEntry = MapEntry(
        "images",
        multipartFile,
      );
      formData.files.add(imageEntry);
    }

    dio.Response response = await dio.Dio().post(
      APIEndpoints.createTask,
      data: formData,
      options: dio.Options(headers: {
        "Content-Type": "multipart/form-data",
        "Authorization": token,
      }),
    );

    var jsonResponse = jsonDecode(response.data);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to create task with error code ${response.statusCode}",
      );
    }

    return true;
  }

  static Future<List<Task>> getAllTask(String token) async {
    final url = Uri.parse(APIEndpoints.getAllTask);

    http.Response response = await http.get(
      url,
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to get tasks with error code ${response.statusCode}",
      );
    }

    List<Task> tasks = [];

    jsonResponse?.forEach((json) {
      Task task = Task.fromJson(json);
      tasks.add(task);
    });

    return tasks;
  }

  static Future<List<ToDo>> getTodoItems(String id, String token) async {
    final url = Uri.parse(APIEndpoints.getTask(id));

    http.Response response = await http.get(
      url,
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to get todo items with error code ${response.statusCode}",
      );
    }

    List<ToDo> todos = [];

    jsonResponse.forEach((json) {
      ToDo todo = ToDo.fromJson(json);
      todos.add(todo);
    });

    return todos;
  }

  static Future<bool> updateTodo({
    required int id,
    required bool isCompleted,
    required bool isInProgress,
    required String token,
  }) async {
    final url = Uri.parse(APIEndpoints.updateTodo(id));

    http.Response response = await http.post(
      url,
      body: jsonEncode({
        "is_completed": isCompleted,
        "is_inprogress": isInProgress,
      }),
      headers: APIEndpoints.postAuthHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ?? "Failed to update todo ${response.statusCode}",
      );
    }

    return true;
  }

  static Future<bool> updateTask({
    required int id,
    required bool isCompleted,
    required bool isCancelled,
    required String token,
  }) async {
    final url = Uri.parse(APIEndpoints.updateTask(id));

    http.Response response = await http.post(
      url,
      body: jsonEncode({
        "is_completed": isCompleted,
        "is_canceled": isCancelled,
      }),
      headers: APIEndpoints.postAuthHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["cannot complete"] ??
            "Failed to update task ${response.statusCode}",
      );
    }

    return true;
  }
}
