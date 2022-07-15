import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Themes {
  /// 亮色主题
  static final light = ThemeData.light().copyWith(
      // 重写主题中的部分参数
      textTheme: const TextTheme().copyWith(
          headline4: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          headline5: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
          subtitle1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          // 用于详情的预览
          bodyText1: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
          // 用于详情的具体显示
          bodyText2: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black)));

  /// 暗色主题
  static final dark = ThemeData.dark().copyWith(
      // 重写主题中的部分参数
      textTheme: const TextTheme().copyWith(
          headline4: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          headline5: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
          subtitle1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          // 用于详情的预览
          bodyText1: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
          // 用于详情的具体显示
          bodyText2: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.black)));

  /// 设置处理自动切换暗黑模式
  static void setAutoChangeDarkMode() {
    SystemChannels.lifecycle.setMessageHandler((message) async {
      switch (message) {
        case "AppLifecycleState.resumed":
          final brightness = MediaQuery.platformBrightnessOf(Get.context!);
          if (brightness == Brightness.dark) {
            Get.changeTheme(Themes.dark);
          } else {
            Get.changeTheme(Themes.light);
          }
          break;
        default:
          break;
      }
      return null;
    });
  }
}
