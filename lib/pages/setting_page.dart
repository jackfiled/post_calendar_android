import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pickers/pickers.dart';

import 'package:post_calendar_android/controllers/setting_controller.dart';

/// 设置界面
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    controller.initContent();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "设置",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => _buildSingleSetting(
                "主题样式",
                controller.themeType.value.name, () {
                  Pickers.showSinglePicker(
                    context,
                    data: ["跟随系统", "白天", "黑夜"],
                    onConfirm: (p, index) {
                      controller.setThemeType(index);
                    }
                  );
              }))
            ],
          ),
        ),
      ),
    );
  }

  /// 构建一条设置选项栏
  ///
  /// [title] 设置的标题
  ///
  /// [content] 设置的内容
  ///
  /// [f] 点击时触发的方法
  Widget _buildSingleSetting(String title, String content, void Function() f) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: f,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      )
    );
  }
}

