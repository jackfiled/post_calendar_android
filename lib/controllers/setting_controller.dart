import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/data_structures/theme_type.dart';

/// 设置控制器
class SettingController extends GetxController {
  final box = HiveProvider
      .getInstance()
      .settingsBox;
  var themeType = ThemeType.system.obs;
  var isJWLogin = false.obs;

  /// 从Hive中读取设置
  Future<void> initContent() async {
    // 读取是否绑定教务处
    var jwStudentID = box.get("jw_id") as String?;
    var jwPassword = box.get("jw_password") as String?;

    if(jwStudentID == null || jwPassword == null){
      isJWLogin.value = false;
    }else{
      isJWLogin.value = true;
    }

    // 获取关于暗黑模式的设置
    // 但不必设置
    // 对于主题的设置在应用程序加载的时候就已经进行了
    final type = box.get("darkMode") as String?;
    if (type == null) {
      box.put("darkMode", ThemeType.system.name);
    } else {
      switch (type) {
        case "system":
          themeType.value = ThemeType.system;
          break;
        case "light":
          themeType.value = ThemeType.light;
          break;
        case "dark":
          themeType.value = ThemeType.dark;
          break;
        default:
          break;
      }
    }
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
  }

  /// 设置主题
  Future<void> setThemeType(int index) async {
    final type = ThemeType.values[index];

    themeType.value = type;
    box.put("darkMode", type.name);


    switch (type) {
      case ThemeType.system:
      //Themes.setAutoChangeDarkMode();
        break;
      case ThemeType.light:
      //Get.changeTheme(Themes.light);
        break;
      case ThemeType.dark:
      //Get.changeTheme(Themes.dark);
        break;
    }
  }
}
