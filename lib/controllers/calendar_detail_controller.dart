import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:post_calendar_android/data_structures/calendar_model.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';

class CalendarDetailController extends GetxController{
  var nameTextController = TextEditingController();
  var placeTextController = TextEditingController();
  var detailsTextController = TextEditingController();
  var beginTime = DateTime(0, 0, 0).obs;
  var endTime = DateTime(0, 0, 0).obs;

  final provider = CalendarProvider.getInstance();
  DateTime? dateBase;
  int? _id;

  /// 读取数据库设置各种初始值
  Future<void> initContent(int id) async {
    var item = await provider.read(id);
    if(item == null){
      return;
    }

    nameTextController.text = item.name;
    placeTextController.text = item.place;
    detailsTextController.text = item.details;
    beginTime.value = item.beginTime;
    endTime.value = item.endTime;
    _id = id;
  }

  /// 设置时间
  Future<void> setDate(int year, int month, int day) async {
    final beginTimeDuration = Duration(
      hours: beginTime.value.hour,
      minutes: beginTime.value.minute,
      seconds: beginTime.value.second
    );
    final endTimeDuration = Duration(
      hours: endTime.value.hour,
      minutes: endTime.value.minute,
      seconds: endTime.value.second
    );

    beginTime.value = DateTime(year, month, day).add(beginTimeDuration);

    endTime.value = DateTime(year, month, day).add(endTimeDuration);
  }

  /// 设置开始时间
  Future<void> setBeginTime(int hour, int minute, int second) async {
    beginTime.value = DateTime(
        beginTime.value.year,
        beginTime.value.month,
        beginTime.value.day
    ).add(Duration(hours: hour, minutes: minute, seconds: second));
  }

  /// 设置结束时间
  Future<void> setEndTime(int hour, int minute, int second) async {
    endTime.value = DateTime(
      endTime.value.year,
      endTime.value.month,
      endTime.value.day
    ).add(Duration(hours: hour, minutes: minute, seconds: second));
  }

  Future<void> createCalendarItem() async {
    CalendarModel item = CalendarModel.inner(
        name: nameTextController.text,
        place: placeTextController.text,
        details: detailsTextController.text,
        beginTime: beginTime.value,
        endTime: endTime.value
    );

    if(_id != null){
      item.id = _id;
      await provider.update(item);
    }else{
      await provider.create(item);
    }
  }

  /// 日期字符串
  String get dateString {
    return "${beginTime.value.year}-"
        "${beginTime.value.month}-"
        "${beginTime.value.day}";
  }

  /// 开始时间字符串
  String get beginTimeString {
    return "${beginTime.value.hour}-"
        "${beginTime.value.minute}-"
        "${beginTime.value.second}";
  }

  /// 结束时间字符串
  String get endTimeString {
    return "${endTime.value.hour}-"
        "${endTime.value.minute}-"
        "${endTime.value.second}";
  }
}