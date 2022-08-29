import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/user_controller.dart';
import 'package:post_calendar_android/components/text_input_widget.dart';
import 'package:post_calendar_android/data_structures/user_info.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameInputController = TextEditingController();
  final studentIDInputController = TextEditingController();
  var classNumberInputString = "未选择".obs;

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
          TextInputWidget(
            controller: nameInputController,
            title: "姓名",
          ),
          TextInputWidget(
            title: "学号",
            controller: studentIDInputController,
          ),
          GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _tapClassNumberInputWidget,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "班级",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Obx(() => Text(
                          classNumberInputString.value,
                          style: Theme.of(context).textTheme.bodyText1,
                        ))
                  ],
                ),
              )),
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

  @override
  void dispose() {
    super.dispose();

    nameInputController.dispose();
    studentIDInputController.dispose();
  }

  Future<void> _confirmClicked() async {
    var studentID = int.tryParse(studentIDInputController.text);
    var classNumber = int.tryParse(classNumberInputString.value);

    if (nameInputController.text.isEmpty ||
        studentID == null ||
        classNumber == null) {
      Get.snackbar("出错了！", "请输入正确的名字和学号");
    } else {
      final info = UserInfo(
          userName: nameInputController.text,
          studentID: studentID,
          classNumber: classNumber);
      Get.back();
      await userController.login(info);
    }
  }

  void _tapClassNumberInputWidget() {
    Pickers.showSinglePicker(context,
        data: [
          "2021211304",
          "2021211305",
          "2021211306",
          "2021211307",
          "2021211308",
          "2021211309"
        ],
        selectData: "2021211304",
        onChanged: (data, pos) => classNumberInputString.value = data);
  }
}
