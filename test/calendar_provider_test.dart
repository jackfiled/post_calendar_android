import 'package:test/test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:post_calendar_android/data_structures/calendar_model.dart';

/// 测试用Calendar数据库类
/// 由于数据库的特殊性
/// 重写了数据库类
class CalendarProviderTest{
  static CalendarProviderTest? _instance;

  static const tableName = "calendar";
  static const columnId = "_id";
  static const columnName = "name";
  static const columnPlace = "place";
  static const columnDetails = "details";
  static const columnBeginTime = "begin_time";
  static const columnEndTime = "end_time";

  late Database _database;

  static CalendarProviderTest getInstance(){
    return _instance ??= CalendarProviderTest();
  }

  Future<void> initDatabase() async {
    sqfliteFfiInit();
    // 更换工厂函数
    databaseFactory = databaseFactoryFfi;

    _database = await openDatabase(inMemoryDatabasePath,
      version: 1,
      onCreate: _onCreate);
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


void main() async {
  final provider = CalendarProviderTest.getInstance();
  await provider.initDatabase();

  group("Database Test", () {
    /// 测试添加功能
    test("Add Item", () async {
      final item = CalendarModel.inner(
          name: "test",
          place: "test",
          details: "test",
          beginTime: DateTime(1),
          endTime: DateTime(2)
      );

      await provider.create(item);

      final testItem = await provider.read(1);
      
      expect(testItem?.name, "test");
    });

    /// 测试更改功能
    test("Update Item", () async {
      final item = await provider.read(1);

      item!.name = "test1";

      await provider.update(item);

      final testItem = await provider.read(1);

      expect(testItem?.name, "test1");
    });

    /// 测试删除数据
    test("Delete Item", () async {
      await provider.delete(1);

      final items = await provider.items();

      expect(items.length, 0);
    });
  });

  tearDownAll(() async {
    await provider.close();
  });
}
