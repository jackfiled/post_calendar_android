import 'package:flutter/material.dart';

import 'package:post_calendar_android/Common/Global.dart';

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
  void set2nextWeek(){
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
  void set2lastWeek(){
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

class CalendarDateHead extends StatefulWidget {
  const CalendarDateHead({Key? key}) : super(key: key);

  @override
  State<CalendarDateHead> createState() => _CalendarDateHeadState();
}

class _CalendarDateHeadState extends State<CalendarDateHead> {
  CalendarHomeViewItem viewItem = CalendarHomeViewItem(DateTime(2022, 4, 3));

  late List<Widget> headTimeList;
  late Table dateHead;

  @override
  void initState() {
    super.initState();

    headTimeList = [
      Container(
          height: 20,
          color: Colors.blue,
          child: const Center(
            child: Text("时间"),
          )),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.sunday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.monday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.tuesday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.wednesday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.thursday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.friday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.saturday),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      //border: TableBorder.all(color: CupertinoColors.extraLightBackgroundGray),//不画边框可能会更好一点
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(CalendarSetting.columnWidth),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
        7: FlexColumnWidth()
      },
      children: <TableRow>[
        TableRow(children: [
          Container(
            height: 20,
            color: Colors.blue,
          ),
          Container(
              height: 20,
              color: Colors.blue,
              child: const Center(
                child: Text("周日"),
              )),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周一"),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周二"),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周三"),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周四"),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周五"),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
            child: const Center(
              child: Text("周六"),
            ),
          ),
        ]),
        TableRow(children: headTimeList)
      ],
    );
  }
}