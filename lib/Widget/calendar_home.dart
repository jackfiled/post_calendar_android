import 'package:flutter/material.dart';
import 'package:post_calendar_android/Widget/Calendar/calendar_data_head_widget.dart';
import 'package:post_calendar_android/Widget/Calendar/calendar_widget.dart';

import 'package:post_calendar_android/Models/calendar.dart';
import 'package:post_calendar_android/Common/global.dart';

class CalendarHome extends StatefulWidget {
  const CalendarHome({Key? key}) : super(key: key);

  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  final double columnHeight = CalendarSetting.columnHeight * 24;

  CalendarManager manager = CalendarManager();

  List<Widget> mondayList = [];
  List<Widget> tuesdayList = [];
  List<Widget> wednesdayList = [];
  List<Widget> thursdayList = [];
  List<Widget> fridayList = [];
  List<Widget> saturdayList = [];
  List<Widget> sundayList = [];

  List<List<Widget>> widgetLists = [];

  @override
  void initState() {
    super.initState();

    widgetLists = [
      mondayList,
      tuesdayList,
      wednesdayList,
      thursdayList,
      fridayList,
      saturdayList,
      sundayList
    ];

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const CalendarDateHead(),
            Expanded(
                child: SizedBox(
                  height: columnHeight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
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
                      children: [
                        TableRow(children: [
                          const CalendarTimeColumn(),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: mondayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: thursdayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: wednesdayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: tuesdayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: fridayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: saturdayList,
                            ),
                          ),
                          SizedBox(
                            height: columnHeight,
                            child: Stack(
                              children: sundayList,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        mini: true,
        onPressed: () => {
          Navigator.pushNamed(context, "/addCalendarItem")
        },
      ),
    );
  }

  /// 从manager中重新刷新数据
  void refresh() async {
    var future = manager.refresh();

    for(List<Widget> l in widgetLists){
      l.clear();
    }

    await future;
    for(int i = 0; i < 7; i++){
      for(CalendarItem item in manager.lists[i]){
        widgetLists[i].add(CalendarItemWidget(calendarItem: item).build());
      }
    }
  }
}

/// 日历左侧的时间
class CalendarTimeColumn extends StatelessWidget {
  const CalendarTimeColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Center(
            child: Text("0:00-1:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("1:00-2:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("2:00-3:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("3:00-4:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("4:00-5:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("5:00-6:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("6:00-7:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("7:00-8:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("8:00-9:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("9:00-10:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("10:00-11:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("11:00-12:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("12:00-13:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("13:00-14:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("14:00-15:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("15:00-16:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("16:00-17:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("17:00-18:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("18:00-19:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("19:00-20:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("20:00-21:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("21:00-22:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("22:00-23:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("23:00-24:00"),
          ),
          height: CalendarSetting.columnHeight,
          width: CalendarSetting.columnWidth,
          color: Colors.blue,
        ),
      ],
    );
  }
}
