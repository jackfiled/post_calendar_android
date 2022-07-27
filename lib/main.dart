import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/configurations/themes.dart';
import 'package:post_calendar_android/data_structures/theme_type.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';
import 'package:post_calendar_android/database/course_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final calendarProvider = CalendarProvider.getInstance();
  final ddlProvider = DDLProvider.getInstance();
  final hiveProvider = HiveProvider.getInstance();
  final courseProvider = CourseProvider.getInstance();

  @override
  void initState() {
    super.initState();

    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.openLoadingPage,
      getPages: RouteConfig.getPages,
      theme: Themes.light,
      darkTheme: Themes.dark,
    );
  }

  @override
  void dispose() {
    super.dispose();

    calendarProvider.close();
    ddlProvider.close();
    courseProvider.close();
  }

  /// 加载App运行所必须的组件
  Future<void> initApp() async {
    final calendarInitFuture = calendarProvider.initDatabase();
    final ddlInitFuture = ddlProvider.initDatabase();
    final courseInitFuture = courseProvider.initDatabase();
    final hiveInitFuture = HiveProvider.initHive();
    final delay = Future.delayed(const Duration(seconds: 2));

    await calendarInitFuture;
    await ddlInitFuture;
    await courseInitFuture;
    await hiveInitFuture;
    // 延迟两秒以展示开屏动画
    await delay;

    Get.offAndToNamed(RouteConfig.main);
  }

  /// 设置主题
  void setTheme() {
    final box = HiveProvider
        .getInstance()
        .settingsBox;
    final type = box.get("darkMode") as String?;

    if (type == null) {
      Themes.setAutoChangeDarkMode();
      box.put("darkMode", ThemeType.system.name);
    } else {
      switch (type) {
        case "system":
          Themes.setAutoChangeDarkMode();
          break;
        case "light":
          Get.changeTheme(Themes.light);
          break;
        case "dark":
          Get.changeTheme(Themes.dark);
          break;
        default:
          break;
      }
    }
  }
}
