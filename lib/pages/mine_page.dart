import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/mine_controller.dart';
import 'package:post_calendar_android/controllers/user_controller.dart';
import 'package:post_calendar_android/data_structures/user_info.dart';
import 'package:post_calendar_android/routes/route_config.dart';

/// "我的"页面
class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  final userController = Get.find<UserController>();
  final controller = Get.put(MineController());

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              if (!userController.isLogin.value) {
                Get.toNamed(RouteConfig.loginPage);
              }
            },
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              child: Obx(() => userController.isLogin.value
                  ? _buildLoginRow(userController.user!)
                  : _buildNoLoginRow()),
            ),
          ),
          const Divider(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "教务系统状态",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Obx(() => Text(
                  controller.isJWLogin.value ? "已绑定" : "未绑定",
                  style: Theme.of(context).textTheme.bodyText1,
                ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Obx(() => ElevatedButton(
              child: Text(controller.isJWLogin.value ? "取消绑定" : "绑定"),
              onPressed: controller.isJWLogin.value ? controller.logoutJW
                  : controller.loginJW,
            )),
          ),
          const Divider(
            height: 20,
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

  Widget _buildNoLoginRow() {
    return Row(
      children: [
        const Icon(
          Icons.no_accounts,
          size: 50,
        ),
        Column(
          children: [
            Text(
              "用户未登录",
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "点击登录",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }

  Widget _buildLoginRow(UserInfo userInfo) {
    return Row(
      children: [
        const Icon(
          Icons.account_circle_rounded,
          size: 50,
        ),
        Column(
          children: [
            Text(
              userInfo.userName,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "所在班级：${userInfo.classNumber}",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        )
      ],
    );
  }
}
