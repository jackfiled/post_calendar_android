import 'package:post_calendar_android/data_structures/course_info_json.dart';
import 'package:post_calendar_android/database/course_provider.dart';

/// 课程信息
class CourseInfo {
  int? id;
  late String name;
  late String place;
  late String teacher;
  late String beginTimeString;
  late String endTimeString;
  late String semester;
  late int week;
  late int dayOfWeek;

  static const double _columnHeight = 80.0;

  /// 构造函数
  CourseInfo({required this.name,
    required this.place,
    required this.teacher,
    required this.beginTimeString,
    required this.endTimeString,
    required this.semester,
    required this.week,
    required this.dayOfWeek});

  /// 从Json对象构造
  CourseInfo.fromJson(CourseInfoJson json, this.semester, this.week) {
    name = json.name;
    place = json.place;
    teacher = json.teacher;
    beginTimeString = json.beginTimeString;
    endTimeString = json.endTimeString;
    dayOfWeek = json.dayOfWeek;
  }

  /// 从数据库构造
  CourseInfo.fromDB(Map<String, dynamic> map) {
    id = map[CourseProvider.idColumn];
    name = map[CourseProvider.nameColumn];
    place = map[CourseProvider.placeColumn];
    teacher = map[CourseProvider.teacherColumn];
    beginTimeString = map[CourseProvider.beginTimeColumn];
    endTimeString = map[CourseProvider.endTimeColumn];
    semester = map[CourseProvider.semesterColumn];
    week = map[CourseProvider.weekColumn];
    dayOfWeek = map[CourseProvider.dayOfWeekColumn];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CourseProvider.nameColumn: name,
      CourseProvider.placeColumn: place,
      CourseProvider.teacherColumn: teacher,
      CourseProvider.beginTimeColumn: beginTimeString,
      CourseProvider.endTimeColumn: endTimeString,
      CourseProvider.semesterColumn: semester,
      CourseProvider.weekColumn: week,
      CourseProvider.dayOfWeekColumn: dayOfWeek
    };

    if (id != null) {
      map[CourseProvider.idColumn] = id;
    }

    return map;
  }

  double get topDistance {
    List<String> list = beginTimeString.split(":");
    int beginHour = int.parse(list[0]);
    int beginMinute = int.parse(list[1]);

    return (beginHour - 8) * _columnHeight + beginMinute / 60 * _columnHeight;
  }

  double get length {
    List<String> list = beginTimeString.split(":");
    int beginHour = int.parse(list[0]);
    int beginMinute = int.parse(list[1]);

    list = endTimeString.split(":");
    int endHour = int.parse(list[0]);
    int endMinute = int.parse(list[1]);

    return (endHour - beginHour) * _columnHeight
        + (endMinute - beginMinute) / 60 * _columnHeight;
  }
}
