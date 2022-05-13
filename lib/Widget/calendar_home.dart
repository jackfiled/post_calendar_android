import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:post_calendar_android/Widget/Calendar/calendar_data_head_widget.dart';
import 'package:post_calendar_android/Widget/Calendar/calendar_widget.dart';
import 'package:post_calendar_android/Widget/Calendar/calendar_time_column_widget.dart';
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
      widgetList.add(CalendarItemWidget(calendarItem: item).build(context));
    }

    return widgetList;
  }
}

