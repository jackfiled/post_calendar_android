import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';

/// "我"页面
class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "回收站",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        GestureDetector(
          onTap: () => Get.toNamed(RouteConfig.ddlALLPage),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DDL垃圾桶",
                style: Theme.of(context).textTheme.headline5,
              ),
              const Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ],
    );
  }
}
