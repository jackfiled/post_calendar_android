import 'package:flutter/material.dart';

import 'package:postcalendar/Widget/calendarHome.dart';
import 'package:postcalendar/Widget/ddlHome.dart';
import 'package:postcalendar/Widget/activityHome.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Welcome to flutter",
      home: IndexPage(),
    );
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  int currentIndex = 0;

  //底部导航栏的选择对象列表
  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.calendar_today),
      label: "日历",
    ),
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.calendar_view_day),
      label: "DDL",
    ),
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.local_activity),
      label: "活动",
    )
  ];

  //需要展示的页面
  final pages = [const CalendarHome(), const DDLHome(), const ActivityHome()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PostCalendar"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          _changePage(index);
        },
      ),

      body: pages[currentIndex],
    );
  }

  void _changePage(int index){
    if(index != currentIndex){
      setState(() {
        currentIndex = index;
      });
    }
  }

}


