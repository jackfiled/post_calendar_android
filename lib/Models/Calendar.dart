import 'package:postcalendar/Common/Global.dart';

class CalendarManager{
  List<CalendarItem> mondayItems = [];
  List<CalendarItem> tuesdayItems = [];
  List<CalendarItem> wednesdayItems = [];
  List<CalendarItem> thursdayItems = [];
  List<CalendarItem> fridayItems = [];
  List<CalendarItem> saturdayItems = [];
  List<CalendarItem> sundayItems = [];

  CalendarManager(){
    CalendarItem testItem = CalendarItem(name: "测试", place: "家里", details: "测试没有详情");
    testItem.setInner(DateTime(2022, 4, 7, 10, 0, 0), DateTime(2022, 4, 7, 11, 0, 0));
    mondayItems.add(testItem);
  }
}







class CalendarItem{
  String name;
  String place;
  String details;
  late DateTime beginTime;
  late DateTime endTime;

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

  CalendarItem({required this.name, required this.place, required this.details});

  void setInner(DateTime _beginTime, DateTime _endTime){
    beginTime = _beginTime;
    endTime = _endTime;
  }

  void setFromDb(String beginTimeStr, String endTimeStr){
    beginTime = DateTime.parse(beginTimeStr);
    endTime = DateTime.parse(endTimeStr);
  }
}