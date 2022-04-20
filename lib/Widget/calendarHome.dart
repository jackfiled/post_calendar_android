import 'package:flutter/material.dart';
import 'package:post_calendar_android/Widget/Calendar/CalendarDateHead.dart';
import 'package:post_calendar_android/Widget/Calendar/CalendarBody.dart';

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
      )
    );
  }
}
