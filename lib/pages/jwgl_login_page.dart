import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/components/text_input_widget.dart';
import 'package:post_calendar_android/database/hive_provider.dart';

class JWGLLoginPage extends StatefulWidget {
  const JWGLLoginPage({Key? key}) : super(key: key);

  @override
  State<JWGLLoginPage> createState() => _JWGLLoginPageState();
}

class _JWGLLoginPageState extends State<JWGLLoginPage> {
  final studentIDController = TextEditingController();
  final passwordController = TextEditingController();
  final box = HiveProvider.getInstance().settingsBox;

  @override
  void dispose() {
    super.dispose();

    studentIDController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("绑定教务系统"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          TextInputWidget(
              controller: studentIDController,
              title: "学号"
          ),
          TextInputWidget(
              controller: passwordController,
              title: "密码"
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _confirmClicked,
                child: Text(
                  "登录",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text(
                  "取消",
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future _confirmClicked() async {
    await box.put("jw_id", studentIDController.text);
    await box.put("jw_password", passwordController.text);
  }
}
