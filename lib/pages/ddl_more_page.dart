import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/controllers/ddl_more_controller.dart';

class DDLMorePage extends StatelessWidget {
  DDLMorePage({Key? key}) : super(key: key);

  final _id = int.parse(Get.parameters['id']!);
  final controller = Get.put(DDLMoreController());

  final titleTextStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold
  );

  final resultTextStyle = const TextStyle(
    fontSize: 20,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    controller.initContent(_id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.create),
            onPressed: () => Get.toNamed(RouteConfig.ddlDetailPage + "?id=$_id"),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Obx(() => Text(
                    controller.name,
                    style: titleTextStyle,
                  ))
                ),
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "地点",
                style: titleTextStyle,
              ),
              Obx(() => Text(
                controller.place,
                style: resultTextStyle,
              ))
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "结束时间",
                  style: titleTextStyle,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                  controller.endTimeString,
                  style: resultTextStyle,
                )),
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "详情",
                  style: titleTextStyle,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                  controller.details,
                  style: resultTextStyle,
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}