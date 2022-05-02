import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:post_calendar_android/Common/global.dart';
import 'package:post_calendar_android/Models/calendar.dart';

class CalendarDateHead extends StatefulWidget {
  const CalendarDateHead({Key? key}) : super(key: key);

  @override
  State<CalendarDateHead> createState() => _CalendarDateHeadState();
}

class _CalendarDateHeadState extends State<CalendarDateHead> {
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
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.monday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.tuesday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.wednesday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.thursday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.friday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.saturday);
            },
          )
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Consumer<CalendarManager>(
            builder: (context, manager, child){
              return Text(manager.calendarHeadViewItem.sunday);
            },
          )
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
          Container(
              height: 20,
              color: Colors.blue,
              child: const Center(
                child: Text("周日"),
              )
          ),
        ]),
        TableRow(children: headTimeList)
      ],
    );
  }
}