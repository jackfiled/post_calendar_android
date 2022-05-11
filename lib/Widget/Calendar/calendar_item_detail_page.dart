import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

import 'package:post_calendar_android/Models/calendar.dart';
import 'package:post_calendar_android/Models/database.dart';

class CalendarItemDetail extends StatefulWidget {
  const CalendarItemDetail({Key? key}) : super(key: key);

  @override
  State<CalendarItemDetail> createState() => _CalendarItemDetailState();
}

class _CalendarItemDetailState extends State<CalendarItemDetail> {
  final nameTextController = TextEditingController();
  final placeTextController = TextEditingController();
  final detailTextController = TextEditingController();

  CalendarProvider provider = CalendarProvider();

  late CalendarItem item;
  DateTime? date;
  DateTime? beginTime;
  DateTime? endTime;

  @override
  void initState() {
    super.initState();
    final id = ModalRoute.of(context)!.settings.arguments as int;
    _getItem(id);

    nameTextController.text = item.name;
    placeTextController.text = item.place;
    detailTextController.text = item.details;

    date = DateTime(item.beginTime.year,
      item.beginTime.month,
      item.beginTime.day
    );

    beginTime = DateTime(1, 1, 1,
      item.beginTime.hour,
      item.beginTime.minute,
      item.beginTime.second
    );

    endTime = DateTime(1, 1, 1,
      item.endTime.hour,
      item.endTime.minute,
      item.endTime.second
    );
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
            onPressed: _updateCalendarItem,
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
                Text(_dateTime2String(beginTime, DateMode.HMS)),
              ],
            ),
          ),
          GestureDetector(
            onTapUp: _selectEndTime,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("日程的结束时间"),
                Text(_dateTime2String(endTime, DateMode.HMS)),
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
                    )
                )
              ]
          )
        ],
      ),
    );
  }

  // 从数据库中读取对应id的日程
  void _getItem(int id) async {
    DBCalendarItem dbCalendarItem = await provider.read(id);
    item = CalendarItem.db(id: dbCalendarItem.id,
        name: dbCalendarItem.name,
        place: dbCalendarItem.place,
        details: dbCalendarItem.details,
        beginTime: DateTime.parse(dbCalendarItem.beginTimeString),
        endTime: DateTime.parse(dbCalendarItem.endTimeString)
    );
  }

  void _updateCalendarItem() async {
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

      item.name = nameTextController.text;
      item.place = placeTextController.text;
      item.details = detailTextController.text;
      item.beginTime = beginDateTime;
      item.endTime = endDateTime;

      DBCalendarItem dbCalendarItem = item.dbItem;
      dbCalendarItem.id = item.id;// 修改数据库需要设置id
      provider.update(dbCalendarItem);
    }else{

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

  @override
  void dispose() {
    super.dispose();

    nameTextController.dispose();
    placeTextController.dispose();
    detailTextController.dispose();
  }

  // 退出界面
  void _close(){
    Navigator.pop(context);
  }
}
