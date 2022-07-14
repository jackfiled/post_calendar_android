import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';

/// 查看SquidDDL详情的界面
class SquidMorePage extends StatelessWidget {
  SquidMorePage({Key? key}) : super(key: key);

  final DDLModel item = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "事件详情",
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
                    child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.headline4,
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
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "${item.endTime.month}月${item.endTime.day}日",
                style: Theme.of(context).textTheme.bodyText2,
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
                        style: Theme.of(context).textTheme.bodyText2,
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
