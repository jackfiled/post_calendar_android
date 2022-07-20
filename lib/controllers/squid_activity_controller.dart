import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/user_controller.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/data_structures/activity_type.dart';
import 'package:post_calendar_android/data_structures/ddl_status.dart';
import 'package:post_calendar_android/network/squid_request.dart';

class SquidActivityController extends GetxController {
  final request = SquidRequest();
  final userController = Get.find<UserController>();

  var items = <DDLModel>[].obs;
  ActivityType type;

  SquidActivityController({
    required this.type,
  });

  Future<void> refreshItems() async {
    final paras = <String, dynamic>{"class": "dddd", "start": 0, "step": 20};

    if (type == ActivityType.all) {
      paras['noticeType'] = -2;
    } else {
      paras['noticeType'] = type.index;
    }

    final squidItems = await request.getList(paras);

    items.clear();

    for (var item in squidItems) {
      final ddlItem = DDLModel.fromSquid(item);

      if(ddlItem.status == DDLStatus.todo){
        items.add(ddlItem);
      }
    }

    // 简单排序
    items.sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  /// 刷新小班的内容
  Future<void> refreshClassDDLItems() async {
    int classNumber = userController.user!.classNumberShort;

    final paras = <String, dynamic>{
      "class": classNumber,
      "start": 0,
      "step": 20
    };

    if (type == ActivityType.all) {
      paras['noticeType'] = -2;
    } else {
      paras['noticeType'] = type.index;
    }

    final squidDDLItems = await request.getList(paras);

    for (var item in squidDDLItems){
      final ddlItem = DDLModel.fromSquid(item);

      if(ddlItem.status == DDLStatus.todo){
        items.add(ddlItem);
      }
    }
  }
}
