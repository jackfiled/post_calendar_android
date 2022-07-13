import 'package:get/get.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/data_structures/ddl_status.dart';

import 'package:post_calendar_android/database/ddl_provider.dart';

class DDLController extends GetxController {
  final provider = DDLProvider.getInstance();

  var ddlItems = (<DDLModel>[]).obs;

  /// 重新读取数据库中的事件
  Future<void> refreshItems() async {
    ddlItems.clear();

    final dbItems = await provider.items();

    // 筛选未完成的事件显示
    ddlItems
        .addAll(dbItems.where((element) => element.status == DDLStatus.todo));

    ddlItems.sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  /// 完成某一事件
  Future<void> finishItem(int id) async {
    final item = await provider.read(id);

    if (item != null) {
      item.status = DDLStatus.finished;

      await provider.update(item);
    }

    await refreshItems();
  }

  /// 删除某一事件
  Future<void> deleteItem(int id) async {
    final item = await provider.read(id);

    if (item != null) {
      item.status = DDLStatus.deleted;

      await provider.update(item);
    }

    await refreshItems();
  }
}
