import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/configurations/themes.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';

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
    );
  }

  @override
  void dispose() {
    super.dispose();

    calendarProvider.close();
    ddlProvider.close();
  }

  /// 加载App运行所必须的组件
  Future<void> initApp() async {
    final calendarInitFuture = calendarProvider.initDatabase();
    final ddlInitFuture = ddlProvider.initDatabase();
    final hiveInitFuture = HiveProvider.initHive();
    final delay = Future.delayed(const Duration(seconds: 2));

    await calendarInitFuture;
    await ddlInitFuture;
    await hiveInitFuture;
    // 延迟两秒以展示开屏动画
    await delay;

    Get.offAndToNamed(RouteConfig.main);
  }
}
