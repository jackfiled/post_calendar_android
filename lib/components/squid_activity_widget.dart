import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/components/ddl_cell_widget.dart';
import 'package:post_calendar_android/data_structures/activity_type.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/controllers/squid_activity_controller.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';
import 'package:post_calendar_android/routes/route_config.dart';

// ignore: must_be_immutable
class SquidActivityWidget extends StatelessWidget {
  final ActivityType type;
  final ddlProvider = DDLProvider.getInstance();
  late SquidActivityController controller;

  SquidActivityWidget({Key? key, required this.type}) : super(key: key) {
    // 为控制器打上tag确保再生成不同的实例
    controller =
        Get.put(SquidActivityController(type: type), tag: type.toString());
  }

  @override
  Widget build(BuildContext context) {
    controller.refreshItems();

    return RefreshIndicator(
      onRefresh: controller.refreshItems,
      child: Obx((() =>
          ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              final item = controller.items[index];

              return DDLCellWidget(
                title: item.name,
                details: item.details,
                endTime: item.endTime,
                onPressed: () {
                  Get.toNamed(RouteConfig.squidMorePage, arguments: item);
                },
                slidableChildren: [
                  SlidableAction(
                    onPressed: (context) {
                      squid2DDL(item);
                    },
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    icon: Icons.add,
                  )
                ],
              );
            },
          ))),
    );
  }

  /// 将事件添加进入DDL数据库
  Future<void> squid2DDL(DDLModel item) async {
    // 添加进数据库的对象应该不设置id
    item.id = null;
    await ddlProvider.create(item);

    Get.snackbar("添加成功", "${item.name}已添加到DDL");
  }
}
