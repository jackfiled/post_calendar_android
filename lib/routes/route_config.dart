import 'package:get/get.dart';

import 'package:post_calendar_android/pages/ddl_more_page.dart';
import 'package:post_calendar_android/pages/home_page.dart';
import 'package:post_calendar_android/pages/calendar_detail_page.dart';
import 'package:post_calendar_android/pages/ddl_detail_page.dart';
import 'package:post_calendar_android/pages/calendar_more_page.dart';
import 'package:post_calendar_android/pages/squid_more_page.dart';
import 'package:post_calendar_android/pages/ddl_all_page.dart';

class RouteConfig {
  /// 主界面
  static const String main = "/";

  /// 日历事件的修改添加页面
  static const String calendarDetailPage = "/CalendarDetailPage";

  static const String calendarMorePage = "/CalendarMorePage";

  static const String ddlDetailPage = "/DDLDetailPage";

  static const String ddlMorePage = "/DDLMorePage";

  static const String squidMorePage = "/SquidMorePage";

  static const String ddlALLPage = "/DDLAllPage";

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => const HomePage()),
    GetPage(name: calendarDetailPage, page: () => const CalendarDetailPage()),
    GetPage(name: ddlDetailPage, page: () => const DDLDetailPage()),
    GetPage(name: calendarMorePage, page: () => CalendarMorePage()),
    GetPage(name: ddlMorePage, page: () => DDLMorePage()),
    GetPage(name: squidMorePage, page: () => SquidMorePage()),
    GetPage(name: ddlALLPage, page: () => DDLAllPage()),
  ];
}
