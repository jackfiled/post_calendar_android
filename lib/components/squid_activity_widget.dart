import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

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
      child: Obx((() => ListView.builder(
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return _buildItemCell(context, controller.items[index]);
            },
          ))),
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
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${item.endTime.year}年${item.endTime.month}月${item.endTime.day}日",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
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
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: Icons.add,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> squid2DDL(DDLModel item) async {
    // 添加进数据库的对象应该不设置id
    item.id = null;
    await ddlProvider.create(item);

    Get.snackbar("添加成功", "${item.name}已添加到DDL");
  }
}
