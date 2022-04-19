import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBCalendarHelper{
  // 先设置数据库文件的相关常量
  static const _databaseName = "Calendar.db";
  static const _databaseVersion = 1;
  static const _tableName = 'Calendar';

  late Database _database;
  static final DBCalendarHelper instance = DBCalendarHelper._privateConstructor();

  DBCalendarHelper();
  DBCalendarHelper._privateConstructor();

  Future<Database> get database async {
    if( _database != null){
      return _database;
    }else{
      _database = await _initDatabase();
      return _database;
    }
  }

  Future<Database> _initDatabase() async{
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute("create table $_tableName(id integer primary key autoincrement, name text, place text, details text, beginTimeString text, endTimeString text)");
  }

  /// 插入数据
  Future<void> create(DBCalendarItem item) async {
    final db = await instance.database;

    await db.insert(_tableName, item.toMap());
  }

  /// 查询所有数据
  Future<List<DBCalendarItem>> items() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    List<DBCalendarItem> items = [];

    for(Map<String, dynamic> map in maps){
      items.add(DBCalendarItem(name: map['name'], place: map['place'],
          details: map['details'], beginTimeString: map['beginTimeString'],
          endTimeString: map['endTimeString']));
    }

    return items;
  }

  /// 读取一个数据
  Future<DBCalendarItem> readItem(int id) async {
    final db = await instance.database;
    
    final List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

    return DBCalendarItem(
        name: maps[0]['name'],
        place: maps[0]['place'],
        details: maps[0]['details'],
        beginTimeString: maps[0]['beginTimeString'],
        endTimeString: maps[0]['endTimeString']);
  }

  /// 修改一条指定的数据
  Future<void> updateItem(DBCalendarItem item) async {
    final db = await instance.database;

    await db.update(_tableName, item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  /// 删除一条指定的数据
  Future<void> deleteItem(int id) async {
    final db = await instance.database;

    await db.delete(_tableName, whereArgs: [id], where: 'id = ?');
  }
}

class DBCalendarItem{
  int? id;
  final String name;
  final String place;
  final String details;
  final String beginTimeString;
  final String endTimeString;

  DBCalendarItem({
    required this.name,
    required this.place,
    required this.details,
    required this.beginTimeString,
    required this.endTimeString
  });

  Map<String, dynamic> toMap() {
    return {
      'id': null,
      'name': name,
      'place': place,
      'details': details,
      'beginTimeString': beginTimeString,
      'endTimeString': endTimeString
    };
  }
}

