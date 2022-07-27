import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Themes {
  /// 亮色主题
  static final light = ThemeData.light().copyWith(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 7, 98, 255),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color.fromARGB(200, 208, 209, 213),
        onPrimaryContainer: Color.fromARGB(255, 8, 39, 138),
        secondary: Color(0xFF625B70),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFE9DEF8),
        onSecondaryContainer: Color(0xFF1E192B),
        tertiary: Color(0xFF7E525F),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFFFD9E2),
        onTertiaryContainer: Color(0xFF31101C),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410002),
        background: Color(0xFFFFFBFF),
        onBackground: Color(0xFF1C1B1E),
        surface: Color(0xFFFFFBFF),
        onSurface: Color(0xFF1C1B1E),
        surfaceVariant: Color(0xFFE7E0EB),
        onSurfaceVariant: Color(0xFF49454E),
        outline: Color(0xFF7A757F),
        onInverseSurface: Color(0xFFF5EFF4),
        inverseSurface: Color(0xFF323033),
        inversePrimary: Color.fromARGB(255, 119, 148, 250),
        shadow: Color(0xFF000000),
        surfaceTint: Color.fromARGB(255, 39, 56, 114),
      ),
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
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 3, 12, 38),
        onPrimary: Color.fromARGB(255, 9, 0, 0),
        primaryContainer: Color(0xFF1F1F28),
        onPrimaryContainer: Color(0xFFEADDFF),
        secondary: Color(0xFFCCC2DB),
        onSecondary: Color(0xFF332D41),
        secondaryContainer: Color(0xFF4A4358),
        onSecondaryContainer: Color(0xFFE9DEF8),
        tertiary: Color(0xFFF0B8C6),
        onTertiary: Color(0xFF4A2531),
        tertiaryContainer: Color(0xFF643B47),
        onTertiaryContainer: Color(0xFFFFD9E2),
        error: Color(0xFFFFB4AB),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFF1C1B1E),
        onBackground: Color(0xFFE6E1E6),
        surface: Color(0xFF1C1B1E),
        onSurface: Color(0xFFE6E1E6),
        surfaceVariant: Color(0xFF49454E),
        onSurfaceVariant: Color(0xFFCBC4CF),
        outline: Color(0xFF948F99),
        onInverseSurface: Color(0xFF1C1B1E),
        inverseSurface: Color(0xFFE6E1E6),
        inversePrimary: Color(0xFF694FA3),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFD1BCFF),
      ),
      // 重写主题中的部分参数
      textTheme: const TextTheme().copyWith(
          headline4: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headline5: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
          subtitle1: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          // 用于详情的预览
          bodyText1: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
          // 用于详情的具体显示
          bodyText2: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white)));

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
