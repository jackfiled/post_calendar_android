import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/user_controller.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/data_structures/ddl_status.dart';
import 'package:post_calendar_android/network/squid_request.dart';

/// 章鱼页面控制器
// 为了使用tabController 似乎必须使用这个被弃用的类
// ignore: deprecated_member_use
class SquidController extends GetxController with SingleGetTickerProviderMixin {
  final request = SquidRequest();
  final userController = Get.find<UserController>();

  late TabController mainTabController;
  late TabController activityTabController;

  // 显示各种对象的列表
  final ddlItems = <DDLModel>[].obs;

  @override
  void onInit() {
    mainTabController = TabController(length: 2, vsync: this);
    activityTabController = TabController(length: 8, vsync: this);
    super.onInit();
  }

  /// 刷新DDL列表的数据
  Future<void> refreshDDLItems() async {
    final paras = <String, dynamic>{
      "class": "dddd",
      "noticeType": 0,
      "start": 0,
      "step": 20
    };

    final squidDDLItems = await request.getList(paras);

    ddlItems.clear();

    if(userController.isLogin.value){
      refreshClassDDLItems();
    }

    for (var item in squidDDLItems) {
      final ddlItem = DDLModel.fromSquid(item);

      if(ddlItem.status == DDLStatus.todo){
        ddlItems.add(ddlItem);
      }
    }

    ddlItems.sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  /// 刷新小班的内容
  Future<void> refreshClassDDLItems() async {
    int classNumber = userController.user!.classNumberShort;

    final paras = <String, dynamic>{
      "class": classNumber,
      "noticeType": 0,
      "start": 0,
      "step": 20
    };

    final squidDDLItems = await request.getList(paras);

    for (var item in squidDDLItems){
      final ddlItem = DDLModel.fromSquid(item);

      if(ddlItem.status == DDLStatus.todo){
        ddlItems.add(ddlItem);
      }
    }
  }
}
