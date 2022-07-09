import 'package:get/get.dart';

import 'package:post_calendar_android/database/ddl_provider.dart';
import 'package:post_calendar_android/data_structures/ddl_model.dart';

class DDLMoreController extends GetxController {
  final provider = DDLProvider.getInstance();
  final _item = Rx<DDLModel?>(null);

  Future<void> initContent(int id) async {
    _item.value = await provider.read(id);
  }

  /// 名字字符串
  String get name {
    if (_item.value == null) {
      return "";
    } else {
      return _item.value!.name;
    }
  }

  /// 详情字符串
  String get details {
    if (_item.value == null) {
      return "";
    } else {
      return _item.value!.details;
    }
  }

  /// 结束时间字符串
  String get endTimeString {
    if (_item.value == null) {
      return "";
    } else {
      return "${_item.value!.endTime.year}年"
          "${_item.value!.endTime.month}月"
          "${_item.value!.endTime.day}日"
          "${_item.value!.endTime.hour}时"
          "${_item.value!.endTime.minute}分"
          "${_item.value!.endTime.second}秒";
    }
  }
}
