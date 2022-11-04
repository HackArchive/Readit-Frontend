// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:clock_hacks_book_reading/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:clock_hacks_book_reading/constants/api_endpoints.dart';

// TODO: Replace dummpy data with serialized objects

class TaskAPI {
  static Future<Task> createTask(
    String token,
    String title,
    String duration,
    String durationType, {
    List<String> exclude = const [],
  }) async {
    final url = Uri.parse(APIEndpoints.createTask);

    http.Response response = await http.post(
      url,
      body: jsonEncode({
        "title": title,
        "duration_type": durationType,
        "duration": duration,
        "exclude": exclude.toString(),
      }),
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to create task with error code ${response.statusCode}",
      );
    }

    return Task.getDummyTask();
  }

  static Future<List<Task>> getAllTask(String token) async {
    final url = Uri.parse(APIEndpoints.getAllTask);

    http.Response response = await http.get(
      url,
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to get tasks with error code ${response.statusCode}",
      );
    }

    return [Task.getDummyTask()];
  }

  static Future<Task> getTask(String id, String token) async {
    final url = Uri.parse(APIEndpoints.getTask(id));

    http.Response response = await http.get(
      url,
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to get task with error code ${response.statusCode}",
      );
    }

    return Task.getDummyTask();
  }

  static Future<Task> updateTask(
    String id,
    bool isCanceled,
    bool isCompleted,
    String token,
  ) async {
    final url = Uri.parse(APIEndpoints.updateTask(id));

    http.Response response = await http.post(
      url,
      body: {
        "is_canceled": isCanceled.toString(),
        "is_completed": isCompleted.toString(),
      },
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to get task with error code ${response.statusCode}",
      );
    }

    return Task.getDummyTask();
  }
}
