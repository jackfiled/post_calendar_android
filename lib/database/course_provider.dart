import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:post_calendar_android/data_structures/course_info.dart';

class CourseProvider {
  static const tableName = "course";
  static const idColumn = "id";
  static const nameColumn = "name";
  static const placeColumn = "place";
  static const teacherColumn = "teacher";
  static const beginTimeColumn = "beginTime";
  static const endTimeColumn = "endTime";
  static const semesterColumn = "semester";
  static const weekColumn = "week";
  static const dayOfWeekColumn = "dayOfWeek";

  late Database _database;

  static CourseProvider? _instance;

  static CourseProvider getInstance() {
    _instance ??= CourseProvider();
    return _instance!;
  }

  /// 初始化数据库
  Future<void> initDatabase() async {
    var path = await getDatabasesPath();
    path = join(path, tableName + ".db");

    _database = await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  /// 关闭数据库
  Future<void> close() async {
    await _database.close();
  }

  /// 创建一个数据
  Future<int> create(CourseInfo info) async {
    return await _database.insert(tableName, info.toMap());
  }

  /// 读取数据库中的某一个对象
  Future<CourseInfo?> read(int id) async {
    List<Map<String, dynamic>> maps = await _database
        .query(tableName, where: "$idColumn = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return CourseInfo.fromDB(maps.first);
    } else {
      return null;
    }
  }

  /// 更新指定数据
  Future<int> update(CourseInfo info) async {
    return await _database.update(tableName, info.toMap(),
        where: "$idColumn = ?", whereArgs: [info.id]);
  }

  /// 删除某个数据
  Future<int> delete(int id) async {
    return _database.delete(tableName, where: "$idColumn = ?", whereArgs: [id]);
  }

  /// 获取所有数据的列表
  Future<List<CourseInfo>> items() async {
    List<Map<String, dynamic>> maps = await _database.query(tableName);
    List<CourseInfo> items = [];

    for (var map in maps) {
      items.add(CourseInfo.fromDB(map));
    }

    return items;
  }

  /// 创建数据库时执行
  Future<void> _onCreate(Database db, int version) async {
    await db.execute("create table $tableName"
        "($idColumn integer primary key autoincrement,"
        "$nameColumn text,"
        "$placeColumn text,"
        "$teacherColumn text,"
        "$semesterColumn text,"
        "$beginTimeColumn text,"
        "$endTimeColumn text,"
        "$weekColumn integer,"
        "$dayOfWeekColumn integer)");
  }
}
