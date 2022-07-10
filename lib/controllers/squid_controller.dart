import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/database/squid_ddl_provider.dart';
import 'package:post_calendar_android/network/squid_request.dart';

/// 章鱼页面控制器
// 为了使用tabController 似乎必须使用这个被弃用的类
// ignore: deprecated_member_use
class SquidController extends GetxController with SingleGetTickerProviderMixin {
  final provider = SquidDDLProvider();
  final request = SquidRequest();

  late TabController mainTabController;
  late TabController activityTabController;

  // 显示各种对象的列表
  final ddlItems = <DDLModel>[].obs;

  final className = "dddd";

  @override
  void onInit() {
    mainTabController = TabController(length: 2, vsync: this);
    activityTabController = TabController(length: 8, vsync: this);
    super.onInit();
  }

  /// 刷新DDL列表的数据
  Future<void> refreshDDLItems() async {
    final paras = <String, dynamic>{
      "class": className,
      "noticeType": 0,
      "start": 0,
      "step": 20
    };

    final squidDDLItems = await request.getList(paras);

    ddlItems.clear();

    for (var item in squidDDLItems) {
      ddlItems.add(DDLModel.fromSquid(item));
    }
  }
}
