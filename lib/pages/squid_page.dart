import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/controllers/squid_controller.dart';

class SquidPage extends StatelessWidget {
  SquidPage({Key? key}) : super(key: key);

  final controller = Get.put(SquidController());

  /// 顶部的导航栏对象列表
  final mainTabs = const <Tab>[
    Tab(
      text: "DDL",
    ),
    Tab(
      text: "活动",
    ),
  ];

  /// 活动界面的导航栏
  final activityTabs = const <Tab>[
    Tab(
      text: "全部",
    ),
    Tab(
      text: "DDL",
    ),
    Tab(
      text: "活动",
    ),
    Tab(
      text: "思政",
    ),
    Tab(
      text: "文体",
    ),
    Tab(
      text: "志愿",
    ),
    Tab(
      text: "讲座",
    ),
    Tab(
      text: "竞赛",
    ),
    Tab(
      text: "评优",
    ),
    Tab(
      text: "其他",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.mainTabController,
          tabs: mainTabs,
        ),
      ),
      body: TabBarView(
        controller: controller.mainTabController,
        children: [
          _buildSquidDDL(context),
          _buildSquidActivity(context),
        ],
      ),
    );
  }

  /// 构建DDL页面
  Widget _buildSquidDDL(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {},
      child: Obx(() => ListView.builder(
            itemCount: controller.ddlItems.length,
            itemBuilder: (context, index) {
              return _buildItemCell(
                context,
                controller.ddlItems[index],
              );
            },
          )),
    );
  }

  Widget _buildSquidActivity(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.activityTabController,
          tabs: activityTabs,
        ),
      ),
      body: TabBarView(
        controller: controller.activityTabController,
        children: [],
      ),
    );
  }

  /// 构建每个单独的DDL事件微件
  Widget _buildItemCell(BuildContext context, DDLModel item) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(
              width: 2, color: const Color.fromARGB(122, 123, 123, 123))),
      child: Slidable(
        key: const ValueKey(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      item.place,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    item.details,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}