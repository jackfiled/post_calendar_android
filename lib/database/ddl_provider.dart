import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:post_calendar_android/data_structures/ddl_model.dart';

/// 内部DDL数据库
class DDLProvider {
  static const tableName = "ddl";
  static const columnId = "_id";
  static const columnName = "name";
  static const columnDetails = "details";
  static const columnEndTime = "end_time";
  static const columnType = "type";
  static const columnStatus = "status";

  late Database _database;

  static DDLProvider? _instance;

  /// 获得单例
  static DDLProvider getInstance() {
    _instance ??= DDLProvider();
    return _instance!;
  }

  /// 初始化数据库
  Future<void> initDatabase() async {
    var _path = await getDatabasesPath();
    String path = join(_path, tableName + ".db");

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> close() async {
    await _database.close();
  }

  /// 创建对象
  Future<int> create(DDLModel item) async {
    return _database.insert(tableName, item.toMap());
  }

  /// 读取所有对象
  Future<List<DDLModel>> items() async {
    List<Map<String, dynamic>> maps = await _database.query(tableName);
    List<DDLModel> items = [];

    for (var map in maps) {
      items.add(DDLModel.fromDB(map));
    }

    return items;
  }

  /// 读取一个对象
  Future<DDLModel?> read(int id) async {
    List<Map<String, dynamic>> maps = await _database
        .query(tableName, where: "$columnId = ?", whereArgs: [id]);

    if (maps.isEmpty) {
      return null;
    } else {
      return DDLModel.fromDB(maps.first);
    }
  }

  /// 更新一个对象
  Future<int> update(DDLModel item) async {
    return _database.update(tableName, item.toMap(),
        where: "$columnId = ?", whereArgs: [item.id]);
  }

  /// 删除一个对象
  Future<int> delete(int id) async {
    return _database.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("create table $tableName"
        "($columnId integer primary key autoincrement,"
        "$columnName text,"
        "$columnDetails text,"
        "$columnEndTime text,"
        "$columnType int,"
        "$columnStatus int)");
  }
}
