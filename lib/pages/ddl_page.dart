import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/ddl_controller.dart';
import 'package:post_calendar_android/components/ddl_item_cell.dart';

/// DDL页面
class DDLPage extends StatelessWidget {
  DDLPage({Key? key}) : super(key: key);

  final controller = Get.put(DDLController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: RefreshIndicator(
          child: Obx(() => 
            ListView.builder(
              itemCount: controller.ddlItems.length,
              itemBuilder: (context, index) {
                final item = controller.ddlItems[index];

                return DDLItemCell(
                  name: item.name, 
                  place: item.place, 
                  details: item.details
                );
              },
            )
          ),
          onRefresh: () => controller.refreshItems(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        child: const Icon(Icons.add),
        mini: true,
      ),
    );
  }
}
