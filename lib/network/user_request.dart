import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:post_calendar_android/data_structures/user_info.dart';

/// UserAPI请求工具类
class UserRequest {
  static const String _baseUrl = "http://rrricardo.top:7000/api/users";

  /// 获得用户登录令牌
  static Future<String> getUserToken(String userName, int studentID) async {
    final url = _baseUrl + "/login?userName=$userName&studentID=$studentID";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw UserAPIException(code: response.statusCode);
    }
  }

  /// 获得用户信息
  static Future<UserInfo> getUserInfo(int studentID, String token) async {
    final url = _baseUrl + "/$studentID";
    final response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: "Bearer " + token,
    });
    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    } else {
      throw UserAPIException(code: response.statusCode);
    }
  }
}

/// 用户请求API的异常
class UserAPIException implements Exception {
  final int code;

  const UserAPIException({
    required this.code
  });

  @override
  String toString() {
    return "用户相关API错误，代码$code";
  }
}
