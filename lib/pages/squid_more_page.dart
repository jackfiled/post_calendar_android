import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';

/// 查看SquidDDL详情的界面
class SquidMorePage extends StatelessWidget {
  SquidMorePage({Key? key}) : super(key: key);

  final DDLModel item = Get.arguments;

  final titleTextStyle =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  final resultTextStyle = const TextStyle(
    fontSize: 20,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    child: Text(
                  item.name,
                  style: titleTextStyle,
                )),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DDL",
                style: titleTextStyle,
              ),
              Text(
                "${item.endTime.month}月${item.endTime.day}日",
                style: resultTextStyle,
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                  height: constraints.maxHeight,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                        item.details,
                        style: resultTextStyle,
                      ),
                    ),
                  ));
            },
          ))
        ],
      ),
    );
  }
}
