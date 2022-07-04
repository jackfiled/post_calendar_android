import 'package:get/get.dart';
import 'package:post_calendar_android/pages/home_page.dart';
import 'package:post_calendar_android/pages/calendar_detail_page.dart';

class RouteConfig{
  /// 主界面
  static const String main = "/";

  /// 日历事件的详情页面
  static const String calendarDetailPage = "/calendarDetailPage";

  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => const HomePage()),
    GetPage(name: calendarDetailPage, page: () => const CalendarDetailPage()),
  ];
}