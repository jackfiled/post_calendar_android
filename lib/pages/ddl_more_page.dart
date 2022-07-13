import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/controllers/ddl_more_controller.dart';

class DDLMorePage extends StatelessWidget {
  DDLMorePage({Key? key}) : super(key: key);

  final _id = int.parse(Get.parameters['id']!);
  final controller = Get.put(DDLMoreController());

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
            onPressed: () =>
                Get.toNamed(RouteConfig.ddlDetailPage + "?id=$_id"),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.initContent(_id),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                      child: Obx(() => Text(
                        controller.name,
                        style: Theme.of(context).textTheme.headline4,
                      ))),
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
                    "结束时间",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() => Text(
                    controller.endTimeString,
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )
              ],
            ),
            Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: Scrollbar(
                          child: SingleChildScrollView(
                            child: Obx(() => Text(
                              controller.details,
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                          )
                      ),
                    );
                  },
                )
            )
          ],
        ),
      )
    );
  }
}
