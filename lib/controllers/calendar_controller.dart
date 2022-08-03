import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/course_info.dart';
import 'package:post_calendar_android/data_structures/semester_info.dart';
import 'package:post_calendar_android/database/course_provider.dart';
import 'package:post_calendar_android/database/hive_provider.dart';
import 'package:post_calendar_android/network/course_info_request.dart';
import 'package:post_calendar_android/network/semester_request.dart';

class CalendarController extends GetxController {
  /// 当前周的第一天
  var weekFirstDay =
      DateTime.now().add(Duration(days: 1 - DateTime.now().weekday)).obs;
  var weekItems = (<CourseInfo>[]).obs;

  var provider = CourseProvider.getInstance();
  var box = HiveProvider.getInstance().settingsBox;
  SemesterInfo? info;

  /// 下一周
  void nextWeek() {
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: 7));

    refreshItems();
  }

  /// 上一周
  void lastWeek() {
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: -7));
    refreshItems();
  }

  /// 从数据库刷新课程
  Future<void> refreshItems() async {
    await getSemester();
    if (info != null) {
      DateTime beginDateTime = DateTime.parse(info!.beginDateTimeString);
      Duration duration = weekFirstDay.value.difference(beginDateTime);
      int week = (duration.inDays / 7 + 1).toInt();

      List<CourseInfo> items = await provider.items();
      weekItems.clear();

      weekItems.addAll(items.where((element) => element.week == week));
    }
  }

  /// 获得当前所在学期
  Future<void> getSemester() async {
    try {
      String semester =
          await SemesterRequest.getSemesterByTime(weekFirstDay.value);
      info = await SemesterRequest.getSemesterInfo(semester);
    } on SemesterAPIException {
      info = null;
    }
  }

  Future<void> getCourses() async {
    String? studentID = await box.get("jw_id") as String?;
    String? password = await box.get("jw_password") as String?;
    String? semester = info?.semester;

    // 判断是否绑定教务系统
    if (studentID == null || password == null) {
      Get.snackbar("未绑定教务系统", "前往‘我的’进行绑定");
      return;
    }

    if (semester == null) {
      Get.snackbar("学期课表未公布", "请等待教务处公布课表");
      return;
    }

    try {
      List<CourseInfo> courses =
          await CourseInfoRequest.getCourses(studentID, password, semester);

      // 删除数据库中过时的课程
      List<CourseInfo> oldCourses = await provider.items();
      for (var course
          in oldCourses.where((element) => element.semester == semester)) {
        await provider.delete(course.id!);
      }

      for (var course in courses) {
        await provider.create(course);
      }

      // 重新获取课程之后
      // 再次刷新
      refreshItems();
    } on CourseAPIException catch (e) {
      Get.snackbar("网络错误", e.toString());
    }
  }

  DateTime get monday => weekFirstDay.value;

  DateTime get tuesday => weekFirstDay.value.add(const Duration(days: 1));

  DateTime get wednesday => weekFirstDay.value.add(const Duration(days: 2));

  DateTime get thursday => weekFirstDay.value.add(const Duration(days: 3));

  DateTime get friday => weekFirstDay.value.add(const Duration(days: 4));

  DateTime get saturday => weekFirstDay.value.add(const Duration(days: 5));

  DateTime get sunday => weekFirstDay.value.add(const Duration(days: 6));

  Iterable<CourseInfo> get mondayItems =>
      weekItems.where((course) => course.dayOfWeek == 1);

  Iterable<CourseInfo> get tuesdayItems =>
      weekItems.where((course) => course.dayOfWeek == 2);

  Iterable<CourseInfo> get wednesdayItems =>
      weekItems.where((course) => course.dayOfWeek == 3);

  Iterable<CourseInfo> get thursdayItems =>
      weekItems.where((course) => course.dayOfWeek == 4);

  Iterable<CourseInfo> get fridayItems =>
      weekItems.where((course) => course.dayOfWeek == 5);

  Iterable<CourseInfo> get saturdayItems =>
      weekItems.where((course) => course.dayOfWeek == 6);

  Iterable<CourseInfo> get sundayItems =>
      weekItems.where((course) => course.dayOfWeek == 7);
}
