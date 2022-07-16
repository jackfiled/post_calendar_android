import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:post_calendar_android/components/ddl_cell_widget.dart';
import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// DDL页面
class DDLPage extends StatelessWidget {
  DDLPage({Key? key}) : super(key: key);

  final controller = Get.put(DDLController());

  @override
  Widget build(BuildContext context) {
    controller.refreshItems();

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

                return DDLCellWidget(
                  title: item.name,
                  details: item.details,
                  endTime: item.endTime,
                  onPressed: () =>
                      Get.toNamed(RouteConfig.ddlMorePage + "?id=${item.id!}"),
                  slidableChildren: [
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
                );
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
}
