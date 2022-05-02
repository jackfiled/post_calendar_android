import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:post_calendar_android/Common/global.dart';
import 'package:post_calendar_android/Models/database.dart';

class CalendarManager extends ChangeNotifier{

  final provider = CalendarProvider();

  late DateTime weekFirstDay;

  List<CalendarItem> mondayItems = [];
  List<CalendarItem> tuesdayItems = [];
  List<CalendarItem> wednesdayItems = [];
  List<CalendarItem> thursdayItems = [];
  List<CalendarItem> fridayItems = [];
  List<CalendarItem> saturdayItems = [];
  List<CalendarItem> sundayItems = [];

  late List<List<CalendarItem>> lists;

  late CalendarHeadViewItem calendarHeadViewItem;

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

    calendarHeadViewItem = CalendarHeadViewItem(weekFirstDay);
  }

  // 刷新日历时间列表
  void refresh() async {
    List<CalendarItem> items = await getWeekItems(weekFirstDay);

    for(List<CalendarItem> l in lists){
      l.clear();
    }

    for(CalendarItem item in items){
      lists[item.beginTime.weekday - 1].add(item);
    }

    notifyListeners();
  }

  // 设置为下一周
  void nextWeek() {
    weekFirstDay = weekFirstDay.add(const Duration(days: 7));
    calendarHeadViewItem.set2nextWeek();
    notifyListeners();
  }

  // 设置为上一周
  void lastWeek() {
    weekFirstDay = weekFirstDay.subtract(const Duration(days: 7));
    calendarHeadViewItem.set2lastWeek();
    notifyListeners();
  }

  Future<List<CalendarItem>> getWeekItems(DateTime time) async {
    final List<DBCalendarItem> dbItems = await provider.items();
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
      if(time.compareTo(item.beginTime) < 0 &&
          time.add(const Duration(days: 7)).compareTo(item.beginTime) > 0){
        resultItems.add(item);
      }
    }

    return resultItems;
  }
}

// 日历时间模型
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

  DBCalendarItem get dbItem =>
      DBCalendarItem(
          name: name,
          place: place,
          details: details,
          beginTimeString: beginTime.toString(),
          endTimeString: endTime.toString()
      );

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

class CalendarHeadViewItem{
  var year = "";
  var monday = "";
  var tuesday = "";
  var wednesday = "";
  var thursday = "";
  var friday = "";
  var saturday = "";
  var sunday = "";

  late DateTime weekFirstDay;
  final oneDay = const Duration(days: 1);

  CalendarHeadViewItem(DateTime timeOfFirstDay){
    weekFirstDay = timeOfFirstDay;
    DateTime date = weekFirstDay;

    year = "${date.year}";
    monday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    tuesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    wednesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    thursday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    friday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    saturday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    sunday = "${date.month}-${date.day}";
  }

  //切换到下一周
  void set2nextWeek(){
    weekFirstDay = weekFirstDay.add(const Duration(days: 7));
    DateTime date = weekFirstDay;

    year = "${date.year}";
    monday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    tuesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    wednesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    thursday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    friday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    saturday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    sunday = "${date.month}-${date.day}";
  }

  //切换到上一周
  void set2lastWeek(){
    weekFirstDay = weekFirstDay.subtract(const Duration(days: 7));
    DateTime date = weekFirstDay;

    year = "${date.year}";
    monday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    tuesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    wednesday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    thursday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    friday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    saturday = "${date.month}-${date.day}";
    date = date.add(oneDay);
    sunday = "${date.month}-${date.day}";
  }
}