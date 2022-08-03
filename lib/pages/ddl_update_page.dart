import 'package:flutter/material.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:flutter_pickers/pickers.dart';

import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/components/text_input_widget.dart';
import 'package:post_calendar_android/controllers/ddl_detail_controller.dart';

/// 添加修改DDL的界面
class DDLUpdatePage extends StatefulWidget {
  const DDLUpdatePage({Key? key}) : super(key: key);

  @override
  State<DDLUpdatePage> createState() => _DDLUpdatePageState();
}

class _DDLUpdatePageState extends State<DDLUpdatePage> {
  final _id = int.parse(Get.parameters['id']!);
  final controller = Get.put(DDLDetailController());
  final ddlController = Get.find<DDLController>();

  @override
  Widget build(BuildContext context) {
    controller.initContent(_id);

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
          Obx(() => _buildTimePickerWidget(
              _selectDate, "DDL结束日期：", controller.dateString)
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => _buildTimePickerWidget(
              _selectEndTime, "DDL结束时间：", controller.endTimeString)
          ),
          const Divider(
            height: 20,
          ),
          TextInputWidget(
            title: "DDL名称",
            controller: controller.nameTextController,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: TextField(
                controller: controller.detailsTextController,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                    labelText: "DDL详情",
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer
                ),
              ),
            ),
          ),
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

  /// 构建时间日期选择的框架
  ///
  /// [tapFunction] 处理点击事件的函数
  ///
  /// [title] 标题
  ///
  /// [result] 选择的结果
  Widget _buildTimePickerWidget(
      void Function() tapFunction, String title, String result) {
    return GestureDetector(
      onTap: tapFunction,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              result,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
