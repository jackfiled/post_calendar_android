import 'package:sqflite/sqflite.dart';

class CalendarSetting{
  // 日历界面左侧时间条的宽度
  static const double columnWidth = 50.0;
  // 日历界面每一个小时的高度
  static const double columnHeight = 80.0;
  // 日历数据库的名称
  static const String databaseName = "Calendar.db";
  // 日历数据库的版本号
  static const int databaseVersion = 1;
  // 日历数据库中表的名称
  static const String tableName = "Calendar";

  static late Database db;
}