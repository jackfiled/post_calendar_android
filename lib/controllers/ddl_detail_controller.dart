import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/data_structures/ddl_model.dart';
import 'package:post_calendar_android/database/ddl_provider.dart';

class DDLDetailController extends GetxController {
  final nameTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final detailsTextController = TextEditingController();
  final provider = DDLProvider.getInstance();

  var endTime = DateTime(1).obs;
  int? _id;

  /// 设置初始值
  Future<void> initContent(int id) async {
    var item = await provider.read(id);
    if (item == null) {
      return;
    }

    nameTextController.text = item.name;
    placeTextController.text = item.place;
    detailsTextController.text = item.details;
    endTime.value = item.endTime;
    _id = id;
  }

  /// 设置日期
  Future<void> setDate(int year, int month, int day) async {
    final endTimeDuration = Duration(
        hours: endTime.value.hour,
        minutes: endTime.value.minute,
        seconds: endTime.value.second);

    endTime.value = DateTime(year, month, day).add(endTimeDuration);
  }

  /// 设置时间
  Future<void> setEndTime(int hour, int minute, int second) async {
    endTime.value =
        DateTime(endTime.value.year, endTime.value.month, endTime.value.day)
            .add(Duration(hours: hour, minutes: minute, seconds: second));
  }

  /// 创建或者修改数据库中的数据
  Future<void> createDDLItem() async {
    DDLModel item = DDLModel(
        name: nameTextController.text,
        place: placeTextController.text,
        details: detailsTextController.text,
        endTime: endTime.value);

    if (_id == null) {
      await provider.create(item);
    } else {
      item.id = _id;
      await provider.update(item);
    }
  }

  /// 日期字符串
  String get dateString {
    return "${endTime.value.year}年"
        "${endTime.value.month}月"
        "${endTime.value.day}日";
  }

  /// 时间字符串
  String get endTimeString {
    return "${endTime.value.hour}时"
        "${endTime.value.minute}分"
        "${endTime.value.second}秒";
  }
}
