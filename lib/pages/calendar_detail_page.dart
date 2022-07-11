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
    if (id != 0) {
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
              onPressed: _confirmButtonClicked, icon: const Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextInputWidget("日程名称", controller.nameTextController),
            const SizedBox(
              height: 20,
            ),
            _buildTextInputWidget("日程地点", controller.placeTextController),
            const SizedBox(
              height: 20,
            ),
            Obx(() => _buildTimePickerWidget(_selectDate, "日程日期", controller.dateString)),
            const SizedBox(
              height: 20,
            ),
            Obx(() => _buildTimePickerWidget(
                _selectBeginTime, "日程开始时间", controller.beginTimeString),),
            const SizedBox(
              height: 20,
            ),
            Obx(() => _buildTimePickerWidget(
                _selectEndTime, "日程结束时间", controller.endTimeString)),
            _buildTextInputWidget("日程明细", controller.detailsTextController)
          ],
        ),
      ),
    );
  }

  /// 退出页面
  void _close() {
    Get.back();
    calendarController.refreshItems();
  }

  /// 选择时间
  void _selectDate() {
    Pickers.showDatePicker(context, mode: DateMode.YMD, onConfirm: (p) {
      controller.setDate(p.year!, p.month!, p.day!);
    });
  }

  /// 选择开始时间
  void _selectBeginTime() {
    Pickers.showDatePicker(context, mode: DateMode.HMS, onConfirm: (p) {
      controller.setBeginTime(p.hour!, p.minute!, p.second!);
    });
  }

  /// 选择结束时间
  void _selectEndTime() {
    Pickers.showDatePicker(context, mode: DateMode.HMS, onConfirm: (p) {
      controller.setEndTime(p.hour!, p.minute!, p.second!);
    });
  }

  /// 点击确认按钮
  void _confirmButtonClicked() {
    controller.createCalendarItem();
  }

  /// 构建输入文字的微件
  ///
  /// [title] 标题
  ///
  /// [c] 输入的控件
  Widget _buildTextInputWidget(String title, TextEditingController c) {
    const titleTextStyle = TextStyle(fontSize: 18, color: Colors.grey);

    return Container(
      height: 70,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: c,
              decoration: InputDecoration(
                labelText: title,
                labelStyle: titleTextStyle,
                border: const OutlineInputBorder()
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 构建时间日期选择的框架
  ///
  /// [tapFunction] 处理点击事件的函数
  ///
  /// [title] 标题
  ///
  /// [result] 选择的结果
  Widget _buildTimePickerWidget(
      void Function() tapFunction, String title, String result) {
    const titleTextStyle = TextStyle(fontSize: 24, color: Colors.grey);

    const resultTextStyle = TextStyle(
      fontSize: 22,
    );

    return GestureDetector(
      onTap: tapFunction,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: titleTextStyle,
            ),
            Text(
              result, 
              style: resultTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
