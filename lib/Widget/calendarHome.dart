import 'package:flutter/material.dart';

import 'package:postcalendar/ViewModel/CalendarHomeView.dart';

class CalendarHome extends StatefulWidget {
  const CalendarHome({Key? key}) : super(key: key);

  @override
  _CalendarHomeState createState() => _CalendarHomeState();
}

class _CalendarHomeState extends State<CalendarHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [CalendarDateHead(), CalendarBody()],
    ));
  }
}

class CalendarDateHead extends StatefulWidget {
  const CalendarDateHead({Key? key}) : super(key: key);

  @override
  State<CalendarDateHead> createState() => _CalendarDateHeadState();
}

class _CalendarDateHeadState extends State<CalendarDateHead> {
  CalendarHomeViewItem viewItem = CalendarHomeViewItem(DateTime(2022, 4, 3));

  late List<Widget> headTimeList;
  late Table dateHead;

  @override
  void initState() {
    super.initState();

    headTimeList = [
      Container(
          height: 20,
          color: Colors.blue,
          child: const Center(
            child: Text("时间"),
          )),
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
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      //border: TableBorder.all(color: CupertinoColors.extraLightBackgroundGray),//不画边框可能会更好一点
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(60.0),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
        6: FlexColumnWidth(),
        7: FlexColumnWidth()
      },
      children: <TableRow>[
        TableRow(children: [
          Container(
            height: 20,
            color: Colors.blue,
          ),
          Container(
              height: 20,
              color: Colors.blue,
              child: const Center(
                child: Text("周日"),
              )),
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
        ]),
        TableRow(children: headTimeList)
      ],
    );
  }
}

class CalendarBody extends StatefulWidget {
  const CalendarBody({Key? key}) : super(key: key);

  @override
  State<CalendarBody> createState() => _CalendarBodyState();
}

class _CalendarBodyState extends State<CalendarBody> {
  final double timeColumnWidth = 60.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            0: FixedColumnWidth(timeColumnWidth),
            1: const FlexColumnWidth(),
            2: const FlexColumnWidth(),
            3: const FlexColumnWidth(),
            4: const FlexColumnWidth(),
            5: const FlexColumnWidth(),
            6: const FlexColumnWidth(),
            7: const FlexColumnWidth()
          },
          children: [
            TableRow(children: [
              Column(
                children: [
                  Container(
                    child: const Center(
                      child: Text("0:00-1:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("1:00-2:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("2:00-3:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("3:00-4:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("4:00-5:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("5:00-6:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("6:00-7:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("7:00-8:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("8:00-9:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("9:00-10:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("10:00-11:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("11:00-12:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("12:00-13:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("13:00-14:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("14:00-15:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("15:00-16:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("16:00-17:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("17:00-18:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("18:00-19:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("19:00-20:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("20:00-21:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("21:00-22:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("22:00-23:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                  Container(
                    child: const Center(
                      child: Text("23:00-24:00"),
                    ),
                    height: 50,
                    width: timeColumnWidth,
                    color: Colors.blue,
                  ),
                ],
              ),
              Column(),
              Column(),
              Column(),
              Column(),
              Column(),
              Column(),
              Column(),
            ])
          ],
        ),
      ),
    );
  }
}