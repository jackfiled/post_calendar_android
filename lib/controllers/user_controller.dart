import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/user_info.dart';
import 'package:post_calendar_android/database/hive_provider.dart';

/// 用户登录控制器
class UserController extends GetxController {
  final box = HiveProvider.getInstance().settingsBox;

  var isLogin = false.obs;
  UserInfo? user;

  /// 检查是否已经登录
  Future<void> checkIsLogin() async {
    // 将用户数据通过JSON的形式存储在hive中
    var json = box.get("user_json") as String?;

    if (json == null) {
      isLogin.value = false;
      user = null;
    } else {
      isLogin.value = true;
      user = UserInfo.fromJson(json);
    }
  }

  /// 登录
  Future<void> login(UserInfo info) async {
    await box.put("user_json", info.toJson());

    user = info;
    isLogin.value = true;
    Get.snackbar("登录成功", "");
  }

  /// 退出
  Future<void> logout() async {
    isLogin.value = false;
    await box.delete("user_json");

    Get.snackbar("退出成功", "点击可再次登录");
  }
}
