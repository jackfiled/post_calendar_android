import 'package:get/get.dart';

import 'package:post_calendar_android/database/calendar_provider.dart';
import 'package:post_calendar_android/data_structures/calendar_model.dart';

class CalendarMoreController extends GetxController{
  final provider = CalendarProvider.getInstance();
  final _item = Rx<CalendarModel?>(null);

  Future<void> initContent(int id) async {
    _item.value = await provider.read(id);
  }

  /// 名称字符串
  String get name {
    if(_item.value == null){
      return "";
    }else{
      return _item.value!.name;
    }
  }

  /// 地点字符串
  String get place {
    if(_item.value == null){
      return "";
    }else{
      return _item.value!.place;
    }
  }

  /// 详情字符串
  String get details {
    if(_item.value == null){
      return "";
    }else{
      return _item.value!.details;
    }
  }

  /// 日期字符串
  String get dataString {
    if(_item.value == null){
      return "";
    }
    else{
      return "${_item.value!.beginTime.year}年"
        "${_item.value!.beginTime.month}月"
        "${_item.value!.beginTime.day}日";
    }
  }

  /// 开始时间字符串
  String get beginTimeString {
    if(_item.value == null){
      return "";
    }
    else{
      return "${_item.value!.beginTime.hour}时"
        "${_item.value!.beginTime.minute}分"
        "${_item.value!.beginTime.second}秒";
    }
  }

  /// 结束时间字符串
  String get endTimeString {
    if(_item.value == null){
      return "";
    }
    else{
      return "${_item.value!.endTime.hour}时"
        "${_item.value!.endTime.minute}分"
        "${_item.value!.endTime.second}秒";
    }
  }
}