import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/controllers/user_controller.dart';
import 'package:post_calendar_android/pages/calendar_page.dart';
import 'package:post_calendar_android/pages/ddl_page.dart';
import 'package:post_calendar_android/pages/squid_page.dart';
import 'package:post_calendar_android/pages/mine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 当前所在页面
  int _index = 0;
  final userController = Get.put(UserController());

  final List<Widget> pages = [
    CalendarPage(),
    DDLPage(),
    SquidPage(),
    const MinePage()
  ];

  @override
  Widget build(BuildContext context) {
    userController.checkIsLogin();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _buildNavItems(),
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[_index],
    );
  }

  /// 切换页面
  void _changePage(int index) {
    if (index != _index) {
      setState(() {
        _index = index;
      });
    }
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    return [
      BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.calendar_today),
          label: "课程表"),
      BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.primary,
          icon: const Icon(Icons.calendar_view_day),
          label: "DDL"),
      BottomNavigationBarItem(
          icon: const Icon(Icons.abc_outlined),
          backgroundColor: Theme.of(context).colorScheme.primary,
          label: "SquidWard"),
      BottomNavigationBarItem(
          icon: const Icon(Icons.account_box),
          backgroundColor: Theme.of(context).colorScheme.primary,
          label: "我"
      )
    ];
  }
}
