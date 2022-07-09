import 'package:flutter/material.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:flutter_pickers/pickers.dart';

import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/controllers/ddl_detail_controller.dart';

class DDLDetailPage extends StatefulWidget {
  const DDLDetailPage({Key? key}) : super(key: key);

  @override
  State<DDLDetailPage> createState() => _DDLDetailPageState();
}

class _DDLDetailPageState extends State<DDLDetailPage> {
  final _id = int.parse(Get.parameters['id']!);
  final controller = Get.put(DDLDetailController());
  final ddlController = Get.find<DDLController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_id == 0 ? "添加DDL" : "修改DDL"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _close,
        ),
        actions: [
          IconButton(
              onPressed: _confirmButtonClicked, icon: const Icon(Icons.check)),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildTextInputWidget("DDL名称", controller.nameTextController),
          const SizedBox(
            height: 20,
          ),
          Obx(() => _buildTimePickerWidget(
              _selectDate, "DDL结束日期", controller.dateString)),
          const SizedBox(
            height: 20,
          ),
          Obx(() => _buildTimePickerWidget(
              _selectEndTime, "DDL结束时间", controller.endTimeString)),
          const SizedBox(
            height: 20,
          ),
          _buildTextInputWidget("DDL详情", controller.detailsTextController)
        ],
      ),
    );
  }

  /// 关闭页面
  /// 同时刷新ddl列表
  void _close() {
    Get.back();
  }

  /// 确定按钮点击
  void _confirmButtonClicked() {
    controller.createDDLItem();
    _close();
  }

  void _selectDate() {
    Pickers.showDatePicker(context, mode: DateMode.YMD, onConfirm: (p) {
      controller.setDate(p.year!, p.month!, p.day!);
    });
  }

  void _selectEndTime() {
    Pickers.showDatePicker(context, mode: DateMode.HMS, onConfirm: (p) {
      controller.setEndTime(p.hour!, p.minute!, p.second!);
    });
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
                  border: const OutlineInputBorder()),
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
