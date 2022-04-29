import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class CalendarProvider{
  // 先设置数据库文件的相关常量
  static const _databaseName = "Calendar.db";
  static const _databaseVersion = 1;
  static const _tableName = 'Calendar';

  late Database db;

  // 打开数据库
  Future open() async {
    // 数据库文件的所在路径
    String path = join(await getDatabasesPath(), _databaseName);
    db = await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  // 数据库中的所有数据
  Future<List<DBCalendarItem>> items() async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    List<DBCalendarItem> items = [];

    for(Map<String, dynamic> map in maps){
      items.add(DBCalendarItem(name: map['name'], place: map['place'],
          details: map['details'], beginTimeString: map['beginTimeString'],
          endTimeString: map['endTimeString']));
    }

    return items;
  }

  // 在数据库中创建数据
  Future create(DBCalendarItem item) async {
    await db.insert(_tableName, item.toMap());
  }

  // 在数据库中读取数据
  Future<DBCalendarItem> read(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    DBCalendarItem item = DBCalendarItem(
        name: maps[0]['name'],
        place: maps[0]['place'],
        details: maps[0]['details'],
        beginTimeString: maps[0]['beginTimeString'],
        endTimeString: maps[0]['endTimeString']
    );

    // 从数据库中读取数据要添加id
    item.id = id;
    return item;
  }

  // 在数据库中更新数据
  Future update(DBCalendarItem item) async {
    await db.update(_tableName, item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  // 在数据中的删除数据
  Future delete(int id) async {
    await db.delete(_tableName, whereArgs: [id], where: 'id = ?');
  }

  // 创建数据库时执行的函数
  Future _onCreate(Database db, int version) async {
    await db.execute("create table $_tableName"
        "(id integer primary key autoincrement, "
        "name text, place text, details text, "
        "beginTimeString text, "
        "endTimeString text)"
    );
  }

  // 在测试中使用sqflite_common_ffi创建的数据库
  void openInTest(Database _db) {
    db = _db;
  }
}

class DBCalendarItem{
  int? id;
  late String name;
  late String place;
  late String details;
  late String beginTimeString;
  late String endTimeString;

  DBCalendarItem({
    required this.name,
    required this.place,
    required this.details,
    required this.beginTimeString,
    required this.endTimeString
  }){
    id = null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'place': place,
      'details': details,
      'beginTimeString': beginTimeString,
      'endTimeString': endTimeString
    };
  }
}

