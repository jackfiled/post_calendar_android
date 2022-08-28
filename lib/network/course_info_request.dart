import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_calendar_android/data_structures/course_info_json.dart';
import 'package:post_calendar_android/data_structures/course_info.dart';

/// 课程API请求类
class CourseInfoRequest {
  static const String _baseUrl = "http://rrricardo.top:7000/calendar";

  static Future<List<CourseInfo>> getCourses(
      String username, String password, String semester) async {
    List<CourseInfo> courses = [];

    final response = await http.post(Uri.parse(_baseUrl + "/get-semester"),
        headers: <String, String>{"Content-Type": "Application/json"},
        body: json.encode(<String, String>{
          "StudentID": username,
          "password": password,
          "semester": semester
        }));

    // 判断返回状态码
    if (response.statusCode == 200) {
      final List jsonMaps = jsonDecode(utf8.decode(response.bodyBytes));

      for (var json in jsonMaps) {
        final courseJson = CourseInfoJson.fromJson(json);
        for (int week in courseJson.weeks) {
          final course = CourseInfo.fromJson(courseJson, semester, week);
          courses.add(course);
        }
      }

      return courses;
    } else {
      throw CourseAPIException(response.body);
    }
  }
}

/// 课程API中请求中的错误
class CourseAPIException implements Exception {
  late String errMessage;

  CourseAPIException(String responseBody) {
    final jsonMaps = jsonDecode(responseBody);
    errMessage = jsonMaps["error"];
  }

  @override
  String toString() {
    return "APIException: " + errMessage;
  }
}
