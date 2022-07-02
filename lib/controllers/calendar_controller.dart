import 'package:get/get.dart';

class CalendarController extends GetxController{
  /// 当前周的第一天
  var weekFirstDay = DateTime.now().add(Duration(days: 1 - DateTime.now().weekday)).obs;

  /// 下一周
  void nextWeek(){
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: 7));
  }

  /// 上一周
  void lastWeek(){
    weekFirstDay.value = weekFirstDay.value.add(const Duration(days: -7));
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
}