import 'dart:async';
import 'package:postcalendar/Common/Global.dart';
import 'package:postcalendar/Models/Database.dart';

class CalendarManager{

  final dbHelper = DBCalendarHelper();
  late DateTime weekFirstDay;

  List<CalendarItem> mondayItems = [];
  List<CalendarItem> tuesdayItems = [];
  List<CalendarItem> wednesdayItems = [];
  List<CalendarItem> thursdayItems = [];
  List<CalendarItem> fridayItems = [];
  List<CalendarItem> saturdayItems = [];
  List<CalendarItem> sundayItems = [];

  late List<List<CalendarItem>> lists;

  CalendarManager() {
    // 为了方便设计的列表
    lists = [
      mondayItems,
      tuesdayItems,
      wednesdayItems,
      thursdayItems,
      fridayItems,
      saturdayItems,
      sundayItems
    ];
    // 获得当前查看周的第一天
    weekFirstDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: - DateTime.now().weekday + 1));

    refresh();
  }

  refresh() async {
    List<CalendarItem> items = await getWeekItems(weekFirstDay);

    for(List<CalendarItem> l in lists){
      l.clear();
    }

    for(CalendarItem item in items){
      lists[item.beginTime.weekday].add(item);
    }
  }

  Future<List<CalendarItem>> getWeekItems(DateTime weekBeginTime) async {
    final List<DBCalendarItem> dbItems = await dbHelper.items();
    final List<CalendarItem> items = [];
    final List<CalendarItem> resultItems = [];

    for(DBCalendarItem item in dbItems){
      items.add(CalendarItem.db(
          id: item.id,
          name: item.name,
          place: item.place,
          details: item.details,
          beginTime: DateTime.parse(item.beginTimeString),
          endTime: DateTime.parse(item.endTimeString)
        )
      );
    }

    for(CalendarItem item in items){
      if(weekBeginTime.compareTo(item.beginTime) < 0 &&
          weekBeginTime.add(const Duration(days: 7)).compareTo(item.beginTime) > 0){
        resultItems.add(item);
      }
    }

    return resultItems;
  }
}

class CalendarItem{
  int? id;
  String name;
  String place;
  String details;
  DateTime beginTime;
  DateTime endTime;

  ///获得事件对象据顶部的高度
  double get topDistance =>
      beginTime.hour * CalendarSetting.columnHeight +
          beginTime.minute * CalendarSetting.columnHeight / 60.0 +
          beginTime.second * CalendarSetting.columnHeight / 3600.0;

  ///获得事件对象的长度
  double get length =>
      (endTime.hour - beginTime.hour) * CalendarSetting.columnHeight +
          (endTime.minute - beginTime.minute) * CalendarSetting.columnHeight / 60.0 +
          (endTime.second - beginTime.second) * CalendarSetting.columnHeight / 3600.0;

  CalendarItem.inner({
    required this.name,
    required this.place,
    required this.details,
    required this.beginTime,
    required this.endTime});

  CalendarItem.db({
    required this.id,
    required this.name,
    required this.place,
    required this.details,
    required this.beginTime,
    required this.endTime
  });
}