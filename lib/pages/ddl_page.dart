import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/components/ddl_item_cell.dart';
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
        child: Obx(() =>
            ListView.builder(
              itemCount: controller.ddlItems.length,
              itemBuilder: (context, index) {
                final item = controller.ddlItems[index];

                return DDLItemCell(
                    item: item,
                );
              },
            )
        ),
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
