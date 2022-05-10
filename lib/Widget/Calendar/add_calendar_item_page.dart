import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

import 'package:post_calendar_android/Models/calendar.dart';
import 'package:post_calendar_android/Models/database.dart';

class AddCalendarItemWidget extends StatefulWidget {
  const AddCalendarItemWidget({Key? key}) : super(key: key);

  @override
  State<AddCalendarItemWidget> createState() => _AddCalendarItemWidgetState();
}

class _AddCalendarItemWidgetState extends State<AddCalendarItemWidget> {
  final nameTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final detailTextController = TextEditingController();

  DateTime? date;
  DateTime? beginTime;
  DateTime? endTime;

  var provider = CalendarProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加一个日历事件"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _close,
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
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: const [
              Text("日程名称")
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "请输入日程的名称"
                  )
                )
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("日程地点")
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
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
            ]
          ),
          GestureDetector(
            onTapUp: _selectDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的日期"),
                Text(_dateTime2String(date, DateMode.YMD)),
              ],
            ),
          ),
          GestureDetector(
            onTapUp: _selectBeginTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的开始时间"),
                Text(_dateTime2String(date, DateMode.HMS)),
              ],
            ),
          ),
          GestureDetector(
            onTapUp: _selectEndTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的结束时间"),
                Text(_dateTime2String(date, DateMode.HMS)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              const Text("日程明细"),
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: detailTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "请输入日程明细",
                  ),
                )
              )
            ]
          )
        ],
      ),
    );
  }

  // 判断一个DateTime是否为空，若是则返回“请输入”
  String _dateTime2String(DateTime? dateTime, DateMode mode) {
    if(dateTime == null){
      return "请输入";
    }else{
      switch (mode) {
        case DateMode.YMD:
          return "${dateTime.year}:${dateTime.month}:${dateTime.day}";
        case DateMode.HMS:
          return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
        default:
          return dateTime.toString();
      }
    }
  }

  // 选择日程日期
  void _selectDate(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.YMD,
        onConfirm: (p){
          setState(() {
            date = DateTime(p.year!, p.month!, p.day!);
          });
        }
    );
  }

  // 选择日程开始时间
  void _selectBeginTime(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.HMS,
        onConfirm: (p){
          setState(() {
            // 这里直接设置年月日为111，反正不需要（
            beginTime = DateTime(1, 1, 1, p.hour!, p.minute!, p.second!);
          });
        }
    );
  }

  // 选择日程结束时间
  void _selectEndTime(TapUpDetails details){
    Pickers.showDatePicker(
        context,
        mode: DateMode.HMS,
        onConfirm: (p){
          setState(() {
            // 这里直接设置年月日为111，反正不需要（
            endTime = DateTime(1, 1, 1, p.hour!, p.minute!, p.second!);
          });
        }
    );
  }


  // 日历事件添加函数
  void _createCalendarItem() async {
    if(date != null && beginTime != null && endTime != null){
      var beginDuration = Duration(hours: beginTime!.hour,
          minutes: beginTime!.minute,
          seconds: beginTime!.second
      );
      var endDuration = Duration(hours: endTime!.hour,
        minutes: endTime!.minute,
        seconds: endTime!.second
      );

      var beginDateTime = date!.add(beginDuration);
      var endDateTime = date!.add(endDuration);

      var item = CalendarItem.inner(
          name: nameTextController.text,
          place: placeTextController.text,
          details: detailTextController.text,
          beginTime: beginDateTime,
          endTime: endDateTime
      );

      await provider.create(item.dbItem);
    }else{

    }

    _close();
  }

  @override
  void dispose() async {
    super.dispose();

    nameTextController.dispose();
    placeTextController.dispose();
    detailTextController.dispose();
  }

  void _close() async {
    Navigator.pop(context);
  }
}

