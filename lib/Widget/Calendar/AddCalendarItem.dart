import 'package:flutter/material.dart';

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
  final DateTime selectedTime = DateTime.now();

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
            onPressed: () => {
              // TODO: 完成添加日历事件的函数
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  const [
              Text("日程名称"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "请输入日程名称",
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  const [
              Text("日程地点"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "请输入日程地点",
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  const [
              Text("日程明细"),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "请输入日程明细",
                ),
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

