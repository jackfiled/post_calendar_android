import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/data_structures/user_info.dart';

/// UserAPI请求工具类
class UserRequest {
  final http.Client _client = http.Client();
  final box = HiveProvider.getInstance().settingsBox;

  static const String _baseUrl = "http://rrricardo.top:7000/api/users";

  /// 登录令牌
  String? authorizationToken;
  /// 学号
  int? studentID;
  /// 用户信息
  UserInfo? user;

  /// 获得登录令牌
  Future<void> getAPIToken(String userName, int studentID) async {
    final loginUrl =
        _baseUrl + "/login?userName=$userName&studentID=$studentID";

    final response = await _client.get(Uri.parse(loginUrl));

    if (response.statusCode == 200) {
      authorizationToken = "Bearer " + response.body;

      box.put("token", authorizationToken);
      box.put("studentID", studentID);
    }
  }

  /// 检验是否已经登录
  Future<bool> checkIsLogin() async {
    final id = box.get("studentID") as int?;
    final token = box.get("token") as String?;

    if(id != null && token != null){
      authorizationToken = token;
      studentID = id;

      user = await getUserInfo();
      return user != null;
    }else{
      return false;
    }
  }

  /// 获得用户信息
  Future<UserInfo?> getUserInfo() async {
    final url = _baseUrl + "/$studentID";

    final response = await _client.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: authorizationToken!,
    });

    if (response.statusCode == 200) {
      return UserInfo.fromJson(jsonDecode(response.body));
    }else{
      return null;
    }
  }
}
