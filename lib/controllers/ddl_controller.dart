import 'package:get/get.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';

import 'package:post_calendar_android/database/ddl_provider.dart';


class DDLController extends GetxController{
  final provider = DDLProvider.getInstance();

  var ddlItems = (<DDLModel>[]).obs;

  /// 重新读取数据库中的事件
  Future<void> refreshItems() async {
    ddlItems.clear();

    ddlItems.value = await provider.items();
  }
}