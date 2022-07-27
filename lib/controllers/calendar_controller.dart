import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/course_info.dart';
import 'package:post_calendar_android/data_structures/semester_info.dart';
import 'package:post_calendar_android/database/course_provider.dart';
import 'package:post_calendar_android/network/semester_request.dart';

class CalendarController extends GetxController {
  /// 当前周的第一天
  var weekFirstDay =
      DateTime.now().add(Duration(days: 1 - DateTime.now().weekday)).obs;

  var weekItems = (<CourseInfo>[]).obs;

  var provider = CourseProvider.getInstance();

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

  Future<void> refreshItems() async {
    try {
      String semester = await SemesterRequest.getSemester();
      SemesterInfo info = await SemesterRequest.getSemesterInfo(semester);

      DateTime beginDateTime = DateTime.parse(info.beginDateTimeString);
      Duration duration = weekFirstDay.value.difference(beginDateTime);
      int week = (duration.inDays / 7 + 1) as int;

      List<CourseInfo> items = await provider.items();
      weekItems.clear();
      weekItems.addAll(items.where((element) => element.week == week));
    } on SemesterAPIException {
      Get.snackbar("出错啦！", "当前学期的课表未公布");
    }
  }

  Future<void> getCourses(String semester) async {}

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
