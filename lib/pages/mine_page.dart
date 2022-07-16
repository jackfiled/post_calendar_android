import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';

/// "我的"页面
class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "我",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Column(
        children: [
          Text(
            "回收站",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          InkWell(
            child: GestureDetector(
                onTap: () => Get.toNamed(RouteConfig.ddlALLPage),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
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
                )),
          ),
          const Divider(
            height: 20,
          ),
          InkWell(
            child: GestureDetector(
              onTap: () => Get.toNamed(RouteConfig.settingPage),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "设置",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
