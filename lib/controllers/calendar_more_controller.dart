import 'package:get/get.dart';

import 'package:post_calendar_android/database/course_provider.dart';
import 'package:post_calendar_android/data_structures/course_info.dart';

class CalendarMoreController extends GetxController{
  final provider = CourseProvider.getInstance();
  final _item = Rx<CourseInfo?>(null);

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

  String get teacher {
    if(_item.value == null){
      return "";
    }else{
      return _item.value!.teacher;
    }
  }

  /// 上课时间字符串
  String get timeString {
    if(_item.value == null){
      return "";
    }
    else{
      return "${_item.value!.beginTimeString}~${_item.value!.endTimeString}";
    }
  }
}