import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:post_calendar_android/data_structures/semester_info.dart';

class SemesterRequest {
  static const String _baseUrl = "http://127.0.0.1:7000/api/semester/";

  static Future<SemesterInfo> getSemesterInfo(String semester) async {
    final url = Uri.parse(_baseUrl + semester);

    final response = await http.get(url);

    if(response.statusCode == 200){
      return SemesterInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }else{
      throw SemesterAPIException();
    }
  }

  static Future<String> getSemester() async {
    final url = Uri.parse(_baseUrl + "time");

    final response = await http.get(url);

    if(response.statusCode == 200){
      return response.body;
    }else{
      throw SemesterAPIException();
    }
  }
}

class SemesterAPIException implements Exception {
  @override
  String toString() {
    return "The semester is invalid";
  }
}
