import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/calendar_more_controller.dart';

class CalendarDetailPage extends StatelessWidget {
  CalendarDetailPage({Key? key}) : super(key: key);

  // 获得
  final _id = int.parse(Get.parameters['id']!);
  final controller = Get.put(CalendarMoreController());

  @override
  Widget build(BuildContext context) {
    controller.initContent(_id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "课程详情",
          style: Theme.of(context).textTheme.headline5,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                    child: Obx(() => Text(controller.name,
                        style: Theme.of(context).textTheme.headline5))),
              )
            ],
          ),
          const SizedBox(
            height: 18, // 只是单纯在这里加上一段空白罢了
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("地点", style: Theme.of(context).textTheme.subtitle1),
              Obx(() => Text(controller.place,
                  style: Theme.of(context).textTheme.bodyText2))
            ],
          ),
          const SizedBox(
            height: 18, // 只是单纯在这里加上一段空白罢了
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("日期", style: Theme.of(context).textTheme.subtitle1),
              Obx(() => Text(controller.timeString,
                  style: Theme.of(context).textTheme.bodyText2))
            ],
          ),
          const SizedBox(
            height: 18, // 只是单纯在这里加上一段空白罢了
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "详情",
                style: Theme.of(context).textTheme.subtitle1,
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                      controller.teacher,
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
