import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:post_calendar_android/data_structures/calendar_model.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';

class CalendarDetailController extends GetxController{
  var nameTextController = TextEditingController();
  var placeTextController = TextEditingController();
  var detailsTextController = TextEditingController();
  Rx<DateTime?> beginTime = null.obs;
  Rx<DateTime?> endTime = null.obs;

  final provider = CalendarProvider.getInstance();
  DateTime? dateBase;

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
  }

  /// 设置时间
  Future<void> setDate(int year, int month, int day) async {
    if(beginTime.value == null){
      beginTime.value = DateTime(year, month, day);
    }else{
      final duration = Duration(
        days: beginTime.value!.hour,
        minutes: beginTime.value!.minute,
        seconds: beginTime.value!.second
      );

      beginTime.value = DateTime(year, month, day);
      beginTime.value!.add(duration);
    }

    if(endTime.value == null){
      endTime.value = DateTime(year, month, day);
    }else{
      final duration = Duration(
        hours: endTime.value!.hour,
        minutes: endTime.value!.minute,
        seconds: endTime.value!.second
      );

      endTime.value = DateTime(year, month, day);
      endTime.value!.add(duration);
    }
  }

  /// 设置开始时间
  Future<void> setBeginTime(int hour, int minute, int second) async {
    if(beginTime.value == null){
      beginTime.value = DateTime(0, 0, 0, hour, minute, second);
    }else{
      beginTime.value = DateTime(
          beginTime.value!.year,
          beginTime.value!.month,
          beginTime.value!.day
      );

      beginTime.value!.add(Duration(
        hours: hour,
        minutes: minute,
        seconds: second
      ));
    }
  }

  /// 设置结束时间
  Future<void> setEndTime(int hour, int minute, int second) async {
    if(endTime.value == null){
      endTime.value = DateTime(0, 0, 0, hour, minute, second);
    }else{
      endTime.value = DateTime(
          endTime.value!.year,
          endTime.value!.month,
          endTime.value!.day
      );

      endTime.value!.add(Duration(
          hours: hour,
          minutes: minute,
          seconds: second
      ));
    }
  }

  Future<void> createCalendarItem() async {
    CalendarModel item = CalendarModel.inner(
        name: nameTextController.text,
        place: placeTextController.text,
        details: detailsTextController.text,
        beginTime: beginTime.value!,
        endTime: endTime.value!
    );

    await provider.create(item);
  }

  /// 日期字符串
  String get dateString {
    if(beginTime.value == null){
      return "";
    }else{
      return "${beginTime.value?.year}-"
          "${beginTime.value?.month}-"
          "${beginTime.value?.day}";
    }
  }

  /// 开始时间字符串
  String get beginTimeString {
    if(beginTime.value == null){
      return "";
    }else{
      return "${beginTime.value?.hour}-"
          "${beginTime.value?.minute}-"
          "${beginTime.value?.second}";
    }
  }

  /// 结束时间字符串
  String get endTimeString {
    if(endTime.value == null){
      return "";
    }
    else{
      return "${endTime.value?.hour}-"
          "${endTime.value?.minute}-"
          "${endTime.value?.second}";
    }
  }

}