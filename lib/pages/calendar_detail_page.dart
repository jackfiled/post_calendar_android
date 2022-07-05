import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:post_calendar_android/controllers/calendar_controller.dart';

import 'package:post_calendar_android/controllers/calendar_detail_controller.dart';

class CalendarDetailPage extends StatefulWidget {
  const CalendarDetailPage({Key? key}) : super(key: key);

  @override
  State<CalendarDetailPage> createState() => _CalendarDetailPageState();
}

class _CalendarDetailPageState extends State<CalendarDetailPage> {
  final int id = int.parse(Get.parameters["id"]!);
  final controller = Get.put(CalendarDetailController());
  final calendarController = Get.find<CalendarController>();

  @override
  Widget build(BuildContext context) {
    if(id != 0){
      controller.initContent(id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? "添加事件" : "修改事件"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _close,
        ),
        actions: [
          IconButton(
              onPressed: _confirmButtonClicked,
              icon: const Icon(Icons.check)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: const [
                Text("日程名称")
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: controller.nameTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "请输入名称"
                      ),
                    )
                )
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text("日程地点")
              ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              textDirection: TextDirection.ltr,
              children: [
                SizedBox(
                  child: TextField(
                    controller: controller.placeTextController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "请输入地点"
                    ),
                  ),
                  width: 200,
                )
              ]
          ),
          GestureDetector(
            onTapUp: _selectDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的日期"),
                Obx(() => Text(controller.dateString)),
              ],
            ),
          ),
          GestureDetector(
            onTapUp: _selectBeginTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的开始时间"),
                Obx(() => Text(controller.beginTimeString)),
              ],
            ),
          ),
          GestureDetector(
            onTapUp: _selectEndTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的结束时间"),
                Obx(() => Text(controller.endTimeString)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("日程明细"),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: controller.detailsTextController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "请输入详情"
                      ),
                    )
                )
              ]
          )
        ],
      ),
    );
  }

  /// 退出页面
  void _close() {
    Get.back();
    calendarController.refreshItems();
  }

  /// 选择时间
  void _selectDate(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.YMD,
        onConfirm: (p){
          controller.setDate(p.year!, p.month!, p.day!);
        }
    );
  }

  /// 选择开始时间
  void _selectBeginTime(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.HMS,
        onConfirm: (p){
          controller.setBeginTime(p.hour!, p.minute!, p.second!);
        }
    );
  }

  /// 选择结束时间
  void _selectEndTime(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.HMS,
        onConfirm: (p){
          controller.setEndTime(p.hour!, p.minute!, p.second!);
        }
    );
  }

  void _confirmButtonClicked(){
    controller.createCalendarItem();
    _close();
  }
}


