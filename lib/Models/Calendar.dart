class CalendarItem{
  String name;
  String place;
  String details;
  late DateTime beginTime;
  late DateTime endTime;

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