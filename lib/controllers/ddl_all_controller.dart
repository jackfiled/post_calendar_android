import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/data_structures/ddl_status.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';

class DDLAllController extends GetxController {
  final provider = DDLProvider.getInstance();

  var ddlItems = (<DDLModel>[]).obs;

  var timeLimit = DateTime(1).obs;

  var statusLimit = DDLStatus.deleted.obs;

  /// Init the dllItems
  /// And the default status is DDLStatus.deleted
  Future<void> initContent() async {
    ddlItems.clear();

    final dbItems = await provider.items();

    ddlItems.addAll(
        dbItems.where((element) => element.status == DDLStatus.deleted));

    ddlItems.sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  /// 筛选需要显示的ddl事件
  Future<void> refreshItems() async {
    final dbItems = await provider.items();

    var mid =
        dbItems.where((element) => element.endTime.isBefore(timeLimit.value));

    mid = mid.where((element) => element.status == statusLimit.value);

    ddlItems.addAll(mid);

    ddlItems.sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  /// 设置时间过滤器
  void setTimeLimit(int year, int month, int day) {
    timeLimit.value = DateTime(year, month, day);

    refreshItems();
  }

  /// 设置状态过滤器
  void setStatueLimit(int pos) {
    statusLimit.value = DDLStatus.values[pos];

    refreshItems();
  }

  /// 删除一个DDL事件
  Future<void> deleteItems(int id) async {
    final item = await provider.read(id);

    await provider.delete(id);

    Get.snackbar("删除成功", "${item!.name}已删除");
  }
  /// 时间过滤器显示字符串
  String get timeLimitString {
    if (timeLimit.value == DateTime(1)) {
      return "未设置时间筛选";
    } else {
      return "截止${timeLimit.value.year}年"
          "${timeLimit.value.month}月"
          "${timeLimit.value.day}日";
    }
  }

  ///状态过滤器字符串
  String get statusLimitString {
    String result;

    switch (statusLimit.value) {
      case DDLStatus.todo:
        result = "未完成";
        break;
      case DDLStatus.finished:
        result = "已完成";
        break;
      case DDLStatus.deleted:
        result = "已删除";
        break;
      case DDLStatus.outdated:
        result = "已过期";
        break;
    }

    return result;
  }
}
