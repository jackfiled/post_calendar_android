import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/database/squid_ddl_provider.dart';
import 'package:post_calendar_android/network/squid_request.dart';
import 'package:post_calendar_android/data_structures/activity_type.dart';

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
  final activtyItems = <DDLModel>[].obs;
  final otherItems = <DDLModel>[].obs;
  final politicsItems = <DDLModel>[].obs;
  final literalItems = <DDLModel>[].obs;
  final volunterrItesm = <DDLModel>[].obs;
  final lectureItems = <DDLModel>[].obs;
  final contestItems = <DDLModel>[].obs;
  final selectionItems = <DDLModel>[].obs;

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

  Future<void> refreshActivityItems(ActivityType type) async {
    var paras = <String, dynamic>{"class": className, "start": 0, "step": 20};

    if (type == ActivityType.all) {
      paras['noticeType'] = 0;
    } else {
      paras['noticeType'] = type.index;
    }

    final items = await request.getList(paras);

    switch (type) {
      case ActivityType.all:
        activtyItems.clear();
        for (var item in items) {
          activtyItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.politics:
        politicsItems.clear();
        for (var item in items) {
          politicsItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.literal:
        literalItems.clear();
        for (var item in items) {
          literalItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.volunteer:
        volunterrItesm.clear();
        for (var item in items) {
          volunterrItesm.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.contest:
        contestItems.clear();
        for (var item in items) {
          contestItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.lecture:
        lectureItems.clear();
        for (var item in items) {
          lectureItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.selection:
        selectionItems.clear();
        for (var item in items) {
          selectionItems.add(DDLModel.fromSquid(item));
        }
        break;
      case ActivityType.other:
        otherItems.clear();
        for (var item in items) {
          otherItems.add(DDLModel.fromSquid(item));
        }
        break;
    }
  }
}
