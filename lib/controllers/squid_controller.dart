import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';

import 'package:post_calendar_android/database/squid_ddl_provider.dart';
import 'package:post_calendar_android/network/squid_request.dart';

/// 章鱼页面控制器
// ignore: deprecated_member_use
// 为了使用tabController 似乎必须使用这个被弃用的类
class SquidController extends GetxController with SingleGetTickerProviderMixin {
  final provider = SquidDDLProvider();
  final request = SquidRequest();

  late TabController mainTabController;
  late TabController activityTabController;

  final ddlItems = <DDLModel>[].obs;
  final activtyItems = <DDLModel>[].obs;

  @override
  void onInit() {
    mainTabController = TabController(length: 2, vsync: this);
    activityTabController = TabController(length: 8, vsync: this);
    super.onInit();
  }
}
