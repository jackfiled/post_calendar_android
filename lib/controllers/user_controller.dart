import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/user_info.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/network/user_request.dart';

/// 用户登录控制器
class UserController extends GetxController {
  final box = HiveProvider.getInstance().settingsBox;

  var isLogin = false.obs;
  UserInfo? user;

  Future<void> checkIsLogin() async {
    var token = box.get("token") as String?;
    var studentID = box.get("studentID") as int?;

    if(token == null || studentID == null){
      isLogin.value = false;
      return;
    }else{
      isLogin.value = true;
      user = await UserRequest.getUserInfo(studentID, token);
    }
  }

  Future<void> login(String userName, int studentID) async {
    isLogin.value = true;
    final token = await UserRequest.getUserToken(userName, studentID);

    box.put("token", token);
    box.put("studentID", studentID);

    user = await UserRequest.getUserInfo(studentID, token);
  }
}
