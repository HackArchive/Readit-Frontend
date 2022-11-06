// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clock_hacks_book_reading/constants/api_endpoints.dart';
import 'package:clock_hacks_book_reading/models/user_model.dart';

class UserAPI {
  static Future<User> login(String email, String password) async {
    final url = Uri.parse(APIEndpoints.login);

    http.Response response = await http.post(
      url,
      body: jsonEncode({"email": email, "password": password}),
      headers: APIEndpoints.postHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to login with error code ${response.statusCode}",
      );
    }

    return User.fromJson(jsonResponse);
  }

  static Future<bool> register(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    final url = Uri.parse(APIEndpoints.register);

    http.Response response = await http.post(
      url,
      body: jsonEncode({
        "name": name,
        "phone_number": phone,
        "email": email,
        "password": password
      }),
      headers: APIEndpoints.postHeaders,
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to login with error code ${response.statusCode}",
      );
    }

    return true;
  }

  static Future<dynamic> getProfile(String token) async {
    final url = Uri.parse(APIEndpoints.profile);

    http.Response response = await http.get(
      url,
      headers: APIEndpoints.authHeaders(token),
    );

    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(
        jsonResponse["err"] ??
            "Failed to login with error code ${response.statusCode}",
      );
    }

    return {
      "books_canceled": jsonResponse["books_canceled"],
      "books_pending": jsonResponse["books_pending"],
      "books_completed": jsonResponse["books_completed"],
    };
  }
}
