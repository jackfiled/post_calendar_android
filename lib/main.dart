import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';
import 'package:post_calendar_android/database/calendar_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final calendarProvider = CalendarProvider.getInstance();

  @override
  void initState(){
    super.initState();

    calendarProvider.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.main,
      getPages: RouteConfig.getPages,
    );
  }

  @override
  void dispose(){
    super.dispose();

    calendarProvider.close();
  }
}

