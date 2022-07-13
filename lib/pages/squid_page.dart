import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/activity_type.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/controllers/squid_controller.dart';
import 'package:post_calendar_android/components/squid_activity_widget.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';
import 'package:post_calendar_android/routes/route_config.dart';

class SquidPage extends StatelessWidget {
  SquidPage({Key? key}) : super(key: key);

  final controller = Get.put(SquidController());
  final ddlProvider = DDLProvider.getInstance();

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
  final activityTabs = const <Widget>[
    Tab(
      text: "全部",
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
    controller.refreshDDLItems();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TabBar(
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
      onRefresh: controller.refreshDDLItems,
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

  /// 构建活动页面
  Widget _buildSquidActivity(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TabBar(
          controller: controller.activityTabController,
          tabs: activityTabs,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: controller.activityTabController,
        children: [
          SquidActivityWidget(type: ActivityType.all),
          SquidActivityWidget(type: ActivityType.politics),
          SquidActivityWidget(type: ActivityType.literal),
          SquidActivityWidget(type: ActivityType.volunteer),
          SquidActivityWidget(type: ActivityType.lecture),
          SquidActivityWidget(type: ActivityType.contest),
          SquidActivityWidget(type: ActivityType.selection),
          SquidActivityWidget(type: ActivityType.other)
        ],
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
        child: GestureDetector(
          onTap: () => Get.toNamed(RouteConfig.squidMorePage, arguments: item),
          child: Slidable(
            key: const ValueKey(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      item.details,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))
              ],
            ),
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                    onPressed: (context) {
                      squid2DDL(item);
                    },
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    icon: Icons.add)
              ],
            ),
          ),
        ));
  }

  /// 添加到DDL数据库
  Future<void> squid2DDL(DDLModel item) async {
    // 添加进数据库中的对象不需要ID
    item.id = null;
    await ddlProvider.create(item);

    Get.snackbar("添加成功", "${item.name}添加到DDL");
  }
}
