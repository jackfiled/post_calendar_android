import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// DDL页面
class DDLPage extends StatelessWidget {
  DDLPage({Key? key}) : super(key: key);

  final controller = Get.put(DDLController());

  @override
  Widget build(BuildContext context) {
    // 两秒之后刷新界面
    Future.delayed(const Duration(seconds: 2), controller.refreshItems);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DDL",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: RefreshIndicator(
        child: Obx(() => ListView.builder(
              itemCount: controller.ddlItems.length,
              itemBuilder: (context, index) {
                final item = controller.ddlItems[index];

                return _buildDDLItemCell(context, item);
              },
            )),
        onRefresh: () => controller.refreshItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteConfig.ddlDetailPage + "?id=0"),
        child: const Icon(Icons.add),
        mini: true,
      ),
    );
  }

  /// 绘制DDL事件单元
  Widget _buildDDLItemCell(BuildContext context, DDLModel item) {
    return Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            border: Border.all(
                width: 2, color: const Color.fromARGB(122, 123, 123, 123))),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(RouteConfig.ddlMorePage + "?id=${item.id!}");
          },
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: [
                SlidableAction(
                  // 完成按钮
                  onPressed: (context) {
                    controller.finishItem(item.id!);
                  },
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.check,
                ),
                SlidableAction(
                  // 编辑按钮
                  onPressed: (context) {
                    Get.toNamed(RouteConfig.ddlDetailPage + "?id=${item.id}");
                  },
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  icon: Icons.create,
                ),
                SlidableAction(
                  // 删除按钮
                  onPressed: (context) {
                    controller.deleteItem(item.id!);
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                )
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.headline5,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
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
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(item.details,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis)),
                ]),
          ),
        ));
  }
}
