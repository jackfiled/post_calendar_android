class CalendarHomeViewItem{
  var year = "";
  var monday = "";
  var tuesday = "";
  var wednesday = "";
  var thursday = "";
  var friday = "";
  var saturday = "";
  var sunday = "";

  late DateTime date;
  final oneDay = const Duration(days: 1);

  CalendarHomeViewItem(DateTime timeOfFirstDay){
    date = timeOfFirstDay;

    year = "${date.year}";
    sunday = "${date.month}-${date.day}";
    date = date.add(oneDay);
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
  }

  //切换到下一周
  void nextWeek(){
    date.add(const Duration(days: 7));

    year = "${date.year}";
    sunday = "${date.month}-${date.day}";
    date = date.add(oneDay);
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
  }

  //切换到上一周
  void lastWeek(){
    date.add(const Duration(days: -7));

    year = "${date.year}";
    sunday = "${date.month}-${date.day}";
    date = date.add(oneDay);
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
  }

}