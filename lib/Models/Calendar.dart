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

  double get topDistance =>
      beginTime.hour * 50.0 + beginTime.minute * 50.0 / 60.0 + beginTime.second * 50.0 / 3600.0;
  double get length =>
      (endTime.hour - beginTime.hour) * 50.0 + (endTime.minute - beginTime.minute) * 50.0 / 60.0 + (endTime.second - beginTime.second) * 50.0 / 3600.0;

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