import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/controllers/calendar_controller.dart';
import 'package:post_calendar_android/data_structures/course_info.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  final controller = Get.put(CalendarController());
  final _columnHeight = 80.0;
  final _columnWidth = 50.0;
  final _columnAllHeight = 80.0 * 14;

  @override
  Widget build(BuildContext context) {
    controller.refreshItems();

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "课程表",
        style: Theme.of(context).textTheme.headline5,
      )),
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
                      TableRow(children: [
                        _buildTimeColumnWidget(),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.mondayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.tuesdayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.wednesdayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.thursdayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.fridayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.saturdayItems),
                              )),
                        ),
                        SizedBox(
                          height: _columnAllHeight,
                          child: Obx(() => Stack(
                                children: _buildCalendarWidgets(
                                    controller.sundayItems),
                              )),
                        ),
                      ])
                    ],
                  ),
                ),
                onRefresh: controller.getCourses,
              ),
              onHorizontalDragEnd: (detail) {
                final direction = detail.velocity.pixelsPerSecond.direction;
                if (direction >= -pi / 2 && direction < pi / 2) {
                  // 向右划
                  controller.lastWeek();
                } else {
                  // 向左划
                  controller.nextWeek();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  /// 获得每天的日历事件列表
  List<Widget> _buildCalendarWidgets(Iterable<CourseInfo> items) {
    List<Widget> list = [];

    for (var item in items) {
      list.add(_buildSingleCalendarWidget(item));
    }

    return list;
  }

  /// 创建单个日历事件控件对象
  Widget _buildSingleCalendarWidget(CourseInfo item) {
    return Positioned(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteConfig.calendarMorePage + "?id=${item.id}");
        },
        child: Container(
          child: Column(
            children: [
              Text(
                item.name,
                style: Theme.of(Get.context!).textTheme.headline6,
              ),
              Text(
                item.place,
                style: Theme.of(Get.context!).textTheme.bodyText2,
              )
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(Get.context!).colorScheme.primary,
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
  Widget _buildCalendarDataHead() {
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
        TableRow(children: [
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周一"),
            ),
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周二"),
            ),
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周三"),
            ),
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周四"),
            ),
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周五"),
            ),
          ),
          Container(
            height: 20,
            color: Theme.of(Get.context!).colorScheme.primary,
            child: const Center(
              child: Text("周六"),
            ),
          ),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: const Center(
                child: Text("周日"),
              )),
        ]),
        TableRow(children: [
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: const Center(
                child: Text("时间"),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.monday.month}-${controller.monday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.tuesday.month}-${controller.tuesday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.wednesday.month}-${controller.wednesday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.thursday.month}-${controller.thursday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.friday.month}-${controller.friday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.saturday.month}-${controller.saturday.day}")),
              )),
          Container(
              height: 20,
              color: Theme.of(Get.context!).colorScheme.primary,
              child: Center(
                child: Obx(() => Text(
                    "${controller.sunday.month}-${controller.sunday.day}")),
              )),
        ])
      ],
    );
  }

  /// 日历时间
  Widget _buildTimeColumnWidget() {
    return Column(
      children: [
        Container(
          child: const Center(
            child: Text("8:00-9:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("9:00-10:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("10:00-11:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("11:00-12:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("12:00-13:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("13:00-14:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("14:00-15:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("15:00-16:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("16:00-17:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("17:00-18:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("18:00-19:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("19:00-20:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("20:00-21:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        Container(
          child: const Center(
            child: Text("21:00-22:00"),
          ),
          height: _columnHeight,
          width: _columnWidth,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
      ],
    );
  }
}
