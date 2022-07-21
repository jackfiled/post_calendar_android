import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:post_calendar_android/data_structures/user_info.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/network/user_request.dart';

/// 用户登录控制器
class UserController extends GetxController {
  final box = HiveProvider.getInstance().settingsBox;

  var isLogin = false.obs;
  UserInfo? user;

  /// 检查是否已经登录
  Future<void> checkIsLogin() async {
    var token = box.get("token") as String?;
    var studentID = box.get("studentID") as int?;

    if (token == null || studentID == null) {
      isLogin.value = false;
      return;
    } else {
      try {
        user = await UserRequest.getUserInfo(studentID, token);
      } on UserAPIException catch (e) {
        Get.snackbar("出错啦！", e.toString());
      }
      isLogin.value = true;
    }
  }

  /// 登录
  Future<void> login(String userName, int studentID) async {
    Get.defaultDialog(
        title: "Loading...",
        titleStyle: Theme.of(Get.context!).textTheme.bodyText2,
        content: const CircularProgressIndicator());
    try {
      final token = await UserRequest.getUserToken(userName, studentID);

      await box.put("token", token);
      await box.put("studentID", studentID);

      user = await UserRequest.getUserInfo(studentID, token);
      isLogin.value = true;
      Get.back();
    } on UserAPIException catch (e) {
      Get.back();
      Get.snackbar("出错啦！", e.toString());
    }
  }

  /// 退出
  Future<void> logout() async {
    isLogin.value = false;
    await box.delete("token");
    await box.delete("studentID");

    Get.snackbar("退出成功", "点击可再次登录");
  }
}
