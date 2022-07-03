import 'package:flutter/material.dart';

import 'package:post_calendar_android/pages/calendar_page.dart';
import 'package:post_calendar_android/pages/ddl_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 当前所在页面
  int _index = 0;

  /// 底部导航栏对象列表
  final List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.calendar_today),
      label: "日历"
      ),
    const BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.calendar_view_day),
      label: "DDL"
      )
  ];

  final List<Widget> pages = [
    CalendarPage(),
    DDLPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("邮历"),
      ),
      bottomNavigationBar:BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          _changePage(index);
        },
      ),
      body: pages[_index],
    );
  }

  /// 切换页面
  void _changePage(int index){
    if(index != _index){
      setState((){
        _index = index;
      });
    }
  }
}