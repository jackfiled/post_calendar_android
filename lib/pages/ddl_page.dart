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
    /// 设置标题的样式
    const titleTextStyle = TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontSize: 28,
        fontWeight: FontWeight.bold);

    /// 设置其他文字的样式
    const otherTextStyle = TextStyle(
        color: Color.fromARGB(122, 139, 136, 136),
        fontSize: 20,
        fontWeight: FontWeight.normal);

    return Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            border: Border.all(
                width: 2, color: const Color.fromARGB(122, 123, 123, 123))),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                // 完成按钮
                onPressed: (context) {},
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
                onPressed: (context) {},
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
                    Text(
                      item.name,
                      style: titleTextStyle,
                    ),
                    Text(
                      "${item.endTime.month}月${item.endTime.day}日",
                      style: otherTextStyle,
                    )
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(item.details,
                        style: otherTextStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis)),
              ]),
        ));
  }
}
