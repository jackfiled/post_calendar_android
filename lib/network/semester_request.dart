import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_calendar_android/data_structures/semester_info.dart';

class SemesterRequest {
  static const String _baseUrl = "http://rrricardo.top:7000/api/semester/";

  /// 获得
  static Future<SemesterInfo> getSemesterInfo(String semester) async {
    final url = Uri.parse(_baseUrl + semester);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SemesterInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw SemesterAPIException(message: response.body);
    }
  }

  /// 获得当天的学期字符串
  static Future<String> getSemesterToday() async {
    final url = Uri.parse(_baseUrl + "time");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw SemesterAPIException(message: response.body);
    }
  }

  /// 指定时间字符串获得学期
  static Future<String> getSemesterByTime(DateTime day) async {
    final url = Uri.parse(_baseUrl + "time/" + day.toIso8601String());

    final response = await http.get(url);

    if(response.statusCode == 200){
      return response.body;
    }else {
      throw SemesterAPIException(message: response.body);
    }
  }
}

/// 请求学期API中的异常
class SemesterAPIException implements Exception {
  String message;

  SemesterAPIException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
