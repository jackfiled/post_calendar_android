import 'package:flutter/material.dart';
import 'package:postcalendar/Models/Calendar.dart';

///日历中显示一件事情的框架对象
class CalendarItemWidget{
  CalendarItem calendarItem;

  CalendarItemWidget({required this.calendarItem});

  Widget build(){
    return Positioned(
      child: Container(
        child: Column(
          children: [
            Text(calendarItem.name),
            Text(calendarItem.place)
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue,
        ),
      ),
      top: calendarItem.topDistance,
      height: calendarItem.length,
      left: 0,
      right: 0,
    );
  }
}