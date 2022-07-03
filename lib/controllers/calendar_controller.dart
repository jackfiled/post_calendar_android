import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/calendar_model.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';

class CalendarController extends GetxController{
  /// 当前周的第一天
  var weekFirstDay = DateTime.now().add(Duration(days: 1 - DateTime.now().weekday)).obs;

  var weekItems = (<CalendarModel>[]).obs;

  var provider = CalendarProvider.getInstance();

  /// 下一周
  void nextWeek(){
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: 7));
  }

  /// 上一周
  void lastWeek(){
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: -7));
  }

  Future<void> refreshItems() async {
    var items = await provider.items();

    weekItems.clear();

    for(var item in items) {
      if(monday.compareTo(item.beginTime) < 0 && sunday.compareTo(item.beginTime) > 0){
        weekItems.add(item);
      }
    }
  }

  DateTime get monday =>
      weekFirstDay.value;

  DateTime get tuesday =>
      weekFirstDay.value.add(const Duration(days: 1));

  DateTime get wednesday =>
      weekFirstDay.value.add(const Duration(days: 2));

  DateTime get thursday =>
      weekFirstDay.value.add(const Duration(days: 3));

  DateTime get friday =>
      weekFirstDay.value.add(const Duration(days: 4));

  DateTime get saturday =>
      weekFirstDay.value.add(const Duration(days: 5));

  DateTime get sunday =>
      weekFirstDay.value.add(const Duration(days: 6));

  Iterable<CalendarModel> get mondayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.monday);

  Iterable<CalendarModel> get tuesdayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.tuesday);

  Iterable<CalendarModel> get wednesdayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.wednesday);

  Iterable<CalendarModel> get thursdayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.thursday);

  Iterable<CalendarModel> get fridayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.friday);

  Iterable<CalendarModel> get saturdayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.saturday);

  Iterable<CalendarModel> get sundayItems =>
      weekItems.where((item) => item.beginTime.weekday == DateTime.sunday);

}