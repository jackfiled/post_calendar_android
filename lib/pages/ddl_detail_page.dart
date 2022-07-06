import 'package:flutter/material.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:post_calendar_android/controllers/calendar_controller.dart';

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
            onPressed: _confirmButtonClicked, 
            icon: const Icon(Icons.check)
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: const [
              Text("DDL名称")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller.nameTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入名称"
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: const [
              Text("DDL地点")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: controller.placeTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入地点"
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: _selectDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("DDL日期"),
                Obx(() => Text(controller.dateString)),
              ],
            ),
          ),
          GestureDetector(
            onTap: _selectEndTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("DDL时间"),
                Obx(() => Text(controller.endTimeString))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: const [
              Text("DDL详情")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.detailsTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "请输入详情"
                ),
              )
            ],
          )
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
    Pickers.showDatePicker(
      context,
      mode: DateMode.YMD,
      onConfirm: (p) {
        controller.setDate(p.year!, p.month!, p.day!);
      }
    );
  }

  void _selectEndTime() {
    Pickers.showDatePicker(
      context,
      mode: DateMode.HMS,
      onConfirm: (p) {
        controller.setEndTime(p.hour!, p.minute!, p.second!);
      }
    );
  }
}


