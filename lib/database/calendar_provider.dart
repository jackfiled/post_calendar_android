import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:post_calendar_android/data_structures/calendar_model.dart';


class CalendarProvider{
  static const tableName = "calendar";
  static const columnId = "_id";
  static const columnName = "name";
  static const columnPlace = "place";
  static const columnDetails = "details";
  static const columnBeginTime = "begin_time";
  static const columnEndTime = "end_time";

  late Database _database;

  static CalendarProvider? _instance;

  /// 获得单例对象
  static CalendarProvider getInstance(){
    _instance ??= CalendarProvider();
    return _instance!;
  }

  /// 初始化数据库
  Future<void> initDatabase() async{
    var _path = await getDatabasesPath();
    String path = join(_path, "Calendar.db");

    _database = await openDatabase(path,
        version: 1,
        onCreate: _onCreate
    );
  }

  /// 关闭数据库函数
  Future<void> close() async{
    await _database.close();
  }

  /// 创建数据对象
  Future<int> create(CalendarModel item) async {
    return _database.insert(tableName, item.toMap());
  }

  /// 读取数据库中的所有数据
  Future<List<CalendarModel>> items() async {
    List<Map<String, dynamic>> maps = await _database.query(tableName);
    List<CalendarModel> items = [];

    for(var map in maps){
      items.add(CalendarModel.fromDB(map));
    }

    return items;
  }

  /// 读取数据库中的某一个对象
  Future<CalendarModel?> read(int id) async {
    List<Map<String, dynamic>> maps = await _database.query(tableName,
        where: "$columnId = ?",
        whereArgs: [id]);

    if (maps.isNotEmpty){
      return CalendarModel.fromDB(maps.first);
    }else{
      return null;
    }
  }

  /// 修改数据库中的某个数据
  Future<int> update(CalendarModel item) async {
    return _database.update(tableName,
        item.toMap(),
        where: "$columnId = ?",
        whereArgs: [item.id]);
  }

  /// 删除某个数据
  Future<int> delete(int id) async {
    return _database.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  /// 创建数据库时执行函数
  Future<void> _onCreate(Database db, int version) async {
    await db.execute("create table $tableName"
        "($columnId integer primary key autoincrement,"
        "$columnName text,"
        "$columnPlace text,"
        "$columnDetails text,"
        "$columnBeginTime text,"
        "$columnEndTime text)"
    );
  }
}