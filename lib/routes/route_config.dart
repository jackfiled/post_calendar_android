import 'package:get/get.dart';

import 'package:post_calendar_android/components/open_loading_page.dart';
import 'package:post_calendar_android/pages/ddl_more_page.dart';
import 'package:post_calendar_android/pages/home_page.dart';
import 'package:post_calendar_android/pages/ddl_detail_page.dart';
import 'package:post_calendar_android/pages/calendar_more_page.dart';
import 'package:post_calendar_android/pages/login_page.dart';
import 'package:post_calendar_android/pages/setting_page.dart';
import 'package:post_calendar_android/pages/squid_more_page.dart';
import 'package:post_calendar_android/pages/ddl_all_page.dart';
import 'package:post_calendar_android/pages/jwgl_login_page.dart';

class RouteConfig {
  /// 主界面
  static const String main = "/";

  /// 启动加载界面
  static const String openLoadingPage = "/openLoadingPage";

  /// 日历事件详情界面
  static const String calendarMorePage = "/CalendarMorePage";

  /// DDL事件的添加修改界面
  static const String ddlDetailPage = "/DDLDetailPage";

  /// DDL事件详情界面
  static const String ddlMorePage = "/DDLMorePage";

  /// Squid Ward的详情界面
  static const String squidMorePage = "/SquidMorePage";

  /// 显示所有DDL事件的界面
  static const String ddlALLPage = "/DDLAllPage";

  /// 设置界面
  static const String settingPage = "/SettingPage";

  /// 登录界面
  static const String loginPage = "/loginPage";

  static const String loginJWGLPage = "/LoginJWGLPage";

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => const HomePage()),
    GetPage(name: openLoadingPage, page: () => const OpenLoadingPage()),
    GetPage(name: ddlDetailPage, page: () => const DDLDetailPage()),
    GetPage(name: calendarMorePage, page: () => CalendarMorePage()),
    GetPage(name: ddlMorePage, page: () => DDLMorePage()),
    GetPage(name: squidMorePage, page: () => SquidMorePage()),
    GetPage(name: ddlALLPage, page: () => DDLAllPage()),
    GetPage(name: settingPage, page: () => const SettingPage()),
    GetPage(name: loginPage, page: () => const LoginPage()),
    GetPage(name: loginJWGLPage, page: () => const JWGLLoginPage())
  ];
}
