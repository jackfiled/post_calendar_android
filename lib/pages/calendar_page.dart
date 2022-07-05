import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:post_calendar_android/routes/route_config.dart';

import 'package:post_calendar_android/controllers/calendar_controller.dart';
import 'package:post_calendar_android/data_structures/calendar_model.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  final controller = Get.put(CalendarController());
  final _columnHeight = 80.0;
  final _columnWidth = 50.0;
  final _columnAllHeight = 80.0 * 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildCalendarDataHead(),
          Expanded(
            child: GestureDetector(
              child: RefreshIndicator(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    columnWidths: <int, TableColumnWidth>{
                      0: FixedColumnWidth(_columnWidth),
                      1: const FlexColumnWidth(),
                      2: const FlexColumnWidth(),
                      3: const FlexColumnWidth(),
                      4: const FlexColumnWidth(),
                      5: const FlexColumnWidth(),
                      6: const FlexColumnWidth(),
                      7: const FlexColumnWidth()
                    },
                    children: [
                        TableRow(
                          children: [
                            _buildTimeColumnWidget(),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.mondayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.tuesdayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.wednesdayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.thursdayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.fridayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.saturdayItems),
                                )
                              ),
                            ),
                            SizedBox(
                              height: _columnAllHeight,
                              child: Obx(() => Stack(
                                children: _buildCalendarWidgets(controller.sundayItems),
                                )
                              ),
                            ),
                          ]
                        )
                    ],
                  ),
                ),
                onRefresh: (){
                  return Future(() => null);
                },
              ),
              onHorizontalDragEnd: (detail){
                final direction = detail.velocity.pixelsPerSecond.direction;
                if(direction >= - pi / 2 && direction < pi / 2){
                  // 向右划
                  controller.lastWeek();
                }else{
                  // 向左划
                  controller.nextWeek();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        mini: true,
        onPressed: (){
          Get.toNamed(RouteConfig.calendarDetailPage + "?id=0");
        },
      ),
    );
  }

  /// 获得每天的日历事件列表
  List<Widget> _buildCalendarWidgets(Iterable<CalendarModel> items){
    List<Widget> list = [];

    for(var item in items){
      list.add(_buildSingleCalendarWidget(item));
    }

    return list;
  }

  /// 创建单个日历事件控件对象
  Widget _buildSingleCalendarWidget(CalendarModel item) {
    return Positioned(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteConfig.calendarDetailPage + "?id=${item.id}");
        },
        child: Container(
          child: Column(
            children: [
              Text(item.name),
              Text(item.details)
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.blue,
          ),
        ),
      ),
      top: item.topDistance,
      height: item.length,
      left: 0,
      right: 0,
    );
  }

  /// 日历表头
  Widget _buildCalendarDataHead(){
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(50),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
        7: FlexColumnWidth()
      },
      children: [
        TableRow(
          children: [
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
          ]
        ),
        TableRow(
          children: [
            Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("时间"),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.monday.month}-${controller.monday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.thursday.month}-${controller.thursday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.wednesday.month}-${controller.wednesday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.tuesday.month}-${controller.tuesday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.friday.month}-${controller.friday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.saturday.month}-${controller.saturday.day}")),
                )
            ),
            Container(
                height: 20,
                color: Colors.blue,
                child:  Center(
                  child: Obx(() => Text("${controller.sunday.month}-${controller.sunday.day}")),
                )
            ),
          ]
        )
      ],
    );
  }

  /// 日历时间
  Widget _buildTimeColumnWidget(){
    return Column(
      children: [
        Container(
          child: const Center(
            child: Text("0:00-1:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("1:00-2:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("2:00-3:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("3:00-4:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("4:00-5:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("5:00-6:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("6:00-7:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("7:00-8:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("8:00-9:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("9:00-10:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("10:00-11:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("11:00-12:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("12:00-13:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("13:00-14:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("14:00-15:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("15:00-16:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("16:00-17:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("17:00-18:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("18:00-19:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("19:00-20:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("20:00-21:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("21:00-22:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("22:00-23:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
        Container(
          child: const Center(
            child: Text("23:00-24:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Colors.blue,
        ),
      ],
    );
  }
}