import 'package:flutter/material.dart';

import 'package:post_calendar_android/Models/calendar.dart';
import 'package:post_calendar_android/Models/database.dart';

class AddCalendarItemWidget extends StatefulWidget {
  const AddCalendarItemWidget({Key? key}) : super(key: key);

  @override
  State<AddCalendarItemWidget> createState() => _AddCalendarItemWidgetState();
}

class _AddCalendarItemWidgetState extends State<AddCalendarItemWidget> {
  late DateTime beginDate;
  late DateTime endDate;
  late TimeOfDay beginTime;
  late TimeOfDay endTime;
  final nameTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final detailTextController = TextEditingController();

  final DateTime selectedTime = DateTime.now();
  var provider = CalendarProvider();

  @override
  void initState() {
    super.initState();
    provider.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加一个日历事件"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context)
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _createCalendarItem,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("日程名称"),
              SizedBox(
                width: 200,
                child: TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "请输入日程名称",
                    ),
                )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("日程地点"),
              SizedBox(
                child: TextField(
                  controller: placeTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入日程地点",
                  ),
                ),
                width: 200,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              const Text("日程明细"),
              SizedBox(
                child: TextField(
                  controller: detailTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入日程明细",
                  ),
                ),
                width: 200,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("开始日期"),
              ElevatedButton(
                  onPressed:() => _selectBeginDate(context),
                  child: const Text(
                      "选择开始日期",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("结束日期"),
              ElevatedButton(
                  onPressed: () => _selectEndDate(context),
                  child: const Text(
                    "选择结束日期",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("开始时间"),
              ElevatedButton(
                  onPressed: () => _selectBeginTime(context),
                  child: const Text(
                    "选择开始时间",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("结束时间"),
              ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: const Text(
                    "选择结束时间",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();

    nameTextController.dispose();
    placeTextController.dispose();
    detailTextController.dispose();

    await provider.close();
  }

  _createCalendarItem() async {
    var beginDuration = Duration(hours: beginTime.hour, minutes: beginTime.minute);
    beginDate = beginDate.add(beginDuration);

    var endDuration = Duration(hours: endTime.hour, minutes: endTime.minute);
    endDate = endDate.add(endDuration);

    var item = CalendarItem.inner(
      name: nameTextController.text,
      place: placeTextController.text,
      details: placeTextController.text,
      beginTime: beginDate,
      endTime: endDate
    );

    await provider.create(item.dbItem);
  }

  /// 显示选择事件开始日期对话
  _selectBeginDate(BuildContext context) async {
    beginDate = (await showDatePicker(
        context: context,
        initialDate: selectedTime,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
        helpText: "选择事件的起始日期",
        confirmText: "确认",
        cancelText: "取消"
      )
    )!;
  }

  /// 显示选择事件结束日期对话
  _selectEndDate(BuildContext context) async {
    endDate = (await showDatePicker(
        context: context,
        initialDate: selectedTime,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
        helpText: "选择事件的结束日期",
        confirmText: "确认",
        cancelText: "取消"
    )
    )!;
  }

  _selectBeginTime(BuildContext context) async {
      beginTime = (await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: selectedTime.hour,
              minute: selectedTime.minute
          ),
          confirmText: "确认",
          cancelText: "取消",
          helpText: "选择事件的开始时间"
        )
      )!;
  }

  _selectEndTime(BuildContext context) async {
    endTime = (await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: selectedTime.hour,
            minute: selectedTime.minute,
        ),
        confirmText: "确认",
        cancelText: "取消",
        helpText: "选择事件的结束时间",
      )
    )!;
  }
}

