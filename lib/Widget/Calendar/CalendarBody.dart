import 'package:flutter/material.dart';
import 'package:postcalendar/Models/Calendar.dart';
import 'package:postcalendar/Widget/Calendar/CalendarWidget.dart';
import 'package:postcalendar/Common/Global.dart';

class CalendarBody extends StatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
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
  }

  @override
  Widget build(BuildContext context) {
    refresh();
    return Expanded(
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
    );
  }

  /// 从manager中重新刷新数据
  void refresh(){
    for(List<Widget> l in widgetLists){
      l.clear();
    }

    for(int i = 0; i < 7; i++){
      for(CalendarItem item in manager.lists[i]){
        widgetLists[i].add(CalendarItemWidget(calendarItem: item).build());
      }
    }
  }
}

///表示日历左边时间的组件
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
