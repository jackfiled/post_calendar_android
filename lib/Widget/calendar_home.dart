import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  ChangeNotifierProvider(
          create: (context) => CalendarManager(),
          child: Column(
            children: [
              const CalendarDateHead(),
              Expanded(
                child: Consumer<CalendarManager>(
                    builder: (context, manager, child){
                      return GestureDetector(
                        child: RefreshIndicator(
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
                                        children:
                                        buildItemWidgetList(manager.mondayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.thursdayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.wednesdayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.thursdayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.fridayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.saturdayItems),
                                      )
                                  ),
                                  SizedBox(
                                      height: columnHeight,
                                      child: Stack(
                                        children:
                                        buildItemWidgetList(manager.sundayItems),
                                      )
                                  ),
                                ])
                              ],
                            ),
                          ),
                          onRefresh: (){
                            return Future.delayed(const Duration(seconds: 1), (){
                              manager.refresh();
                            });
                          },
                        ),
                        onHorizontalDragEnd: (detail){
                          final double direction =
                              detail.velocity.pixelsPerSecond.direction;
                          if(direction > - pi / 2 && direction < pi / 2){
                            manager.lastWeek();
                            manager.refresh();
                          }else{
                            manager.nextWeek();
                            manager.refresh();
                          }
                        },
                      );
                    }),
              )
            ],
          ),
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

  List<Widget> buildItemWidgetList(List<CalendarItem> list){
    List<Widget> widgetList = [];

    for(var item in list){
      widgetList.add(CalendarItemWidget(calendarItem: item).build());
    }

    return widgetList;
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
