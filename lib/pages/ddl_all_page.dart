import 'package:flutter/material.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_pickers/pickers.dart';

import 'package:post_calendar_android/components/ddl_cell_widget.dart';
import 'package:post_calendar_android/controllers/ddl_all_controller.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// Display all dll items
/// Use in the rubbish page
class DDLAllPage extends StatelessWidget {
  DDLAllPage({Key? key}) : super(key: key);

  final controller = DDLAllController();

  @override
  Widget build(BuildContext context) {
    controller.initContent();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DDL垃圾桶",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Pickers.showDatePicker(context,
                      mode: DateMode.YMD,
                      onConfirm: (p) =>
                          controller.setTimeLimit(p.year!, p.month!, p.day!));
                },
                child: Obx(() =>
                    Text(controller.timeLimitString,
                        style: Theme
                            .of(context)
                            .textTheme
                            .button)),
              ),
              ElevatedButton(
                onPressed: () {
                  Pickers.showSinglePicker(
                    context,
                    data: ["未完成", "已完成", "已过期", "已删除"],
                    onConfirm: (p, index) => controller.setStatueLimit(index),
                  );
                },
                child: Obx(() =>
                    Text(
                      controller.statusLimitString,
                      style: Theme
                          .of(context)
                          .textTheme
                          .button,
                    )),
              )
            ],
          ),
          Expanded(
            child: Obx(() =>
                ListView.builder(
                  itemCount: controller.ddlItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.ddlItems[index];

                    return DDLCellWidget(
                      title: item.name,
                      details: item.details,
                      endTime: item.endTime,
                      onPressed: () {
                        Get.toNamed(RouteConfig.ddlDetailPage + "?id=${item.id}");
                      },
                      slidableChildren: [
                        SlidableAction(
                          onPressed: (context) =>
                              Get.toNamed(RouteConfig.ddlDetailPage + "?id=${item.id}"),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          icon: Icons.create,
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            Get.defaultDialog(
                                title: "警告",
                                titleStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5,
                                middleText: "真的要删除吗？",
                                middleTextStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText2,
                                onConfirm: () {

                                }
                            );
                          },
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        )
                      ],
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
