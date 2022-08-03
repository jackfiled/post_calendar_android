import 'package:get/get.dart';

import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// "我的"页面控制器
class MineController extends GetxController {
  final box = HiveProvider
      .getInstance()
      .settingsBox;
  final isJWLogin = false.obs;

  /// 初始化控制器
  Future<void> initContent() async {
    checkJwLogin();
  }

  // 登录教务系统
  Future<void> loginJW() async {
    Get.toNamed(RouteConfig.loginJWGLPage);
  }

  // 退出教务系统
  Future<void> logoutJW() async {
    await box.delete("jw_id");
    await box.delete("jw_password");

    Get.snackbar("解绑成功", "同教务系统的绑定已解除");
    checkJwLogin();
  }

  /// 检测教务系统是否绑定
  void checkJwLogin() {
    String? jwStudentID = box.get("jw_id") as String?;
    String? jwPassword = box.get("jw_password") as String?;

    if (jwStudentID == null || jwPassword == null) {
      isJWLogin.value = false;
    } else {
      isJWLogin.value = true;
    }
  }
}