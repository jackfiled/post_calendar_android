import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameInputController = TextEditingController();
  final studentIDInputController = TextEditingController();

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "登录",
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Text(
            "用户登录",
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameInputController,
              decoration: InputDecoration(
                  labelText: "姓名",
                  labelStyle: Theme.of(context).textTheme.headline4,
                  border: const OutlineInputBorder()),
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: studentIDInputController,
              decoration: InputDecoration(
                  labelText: "学号",
                  labelStyle: Theme.of(context).textTheme.headline4,
                  border: const OutlineInputBorder()),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: _confirmClicked,
                child: Text(
                  "登录",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "取消",
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    nameInputController.dispose();
    studentIDInputController.dispose();
  }

  Future<void> _confirmClicked() async {
    var studentID = int.tryParse(studentIDInputController.text);

    if(nameInputController.text.isEmpty || studentID == null){
      Get.snackbar("出错了！", "请输入正确的名字和学号");
    }else{
      await userController.login(nameInputController.text, studentID);
      Get.back();
    }
  }
}
