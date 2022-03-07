import 'package:flutter/material.dart';

import 'package:postcalendar/ViewModel/CalendarHomeView.dart';

class CalendarHome extends StatefulWidget {
  const CalendarHome({Key? key}) : super(key: key);

  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  var viewItem = CalendarHomeViewItem(DateTime(2022,2,27));
  List<Container> headTimeList = [];
  late Widget head;
  late Widget calendarBody;

  @override
  void initState() {
    super.initState();

    headTimeList = [
      Container(
        height: 20,
        color: Colors.blue,
        child: const Center(
          child: Text("时间"),
        )
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.sunday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.monday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.tuesday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.wednesday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.thursday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.friday),
        ),
      ),
      Container(
        height: 20,
        color: Colors.blue,
        child: Center(
          child: Text(viewItem.saturday),
        ),
      ),
    ];

    head = Table(
      //border: TableBorder.all(color: CupertinoColors.extraLightBackgroundGray),//不画边框可能会更更好一点
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
        7: FlexColumnWidth()
      },
      children: <TableRow>[
        TableRow(
            children:[
              Container(
                height: 20,
                color: Colors.blue,
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周日"),
                )
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周一"),
                ),
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周二"),
                ),
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周三"),
                ),
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周四"),
                ),
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周五"),
                ),
              ),
              Container(
                height: 20,
                color: Colors.blue,
                child: const Center(
                  child: Text("周六"),
                ),
              ),
            ]
        ),
        TableRow(
            children: headTimeList
        )
      ],
    );

    calendarBody = Container(
      child: ListView(
        children: [
          Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(20),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(),
              7: FlexColumnWidth(),
            },//设置表格中栏目的宽度
            children: [
              TableRow(
                  children: [
                    Container(

                    )
                  ]
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            head,
            calendarBody,
          ],
        )
    );
  }
}

