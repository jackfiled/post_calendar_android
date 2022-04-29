import 'package:test/test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:post_calendar_android/Models/Database.dart';

void main() async {
  final provider = CalendarProvider();
  late Database db;

  setUpAll(() async {
    sqfliteFfiInit();
    // 更换默认的工厂函数为ffi
    databaseFactory = databaseFactoryFfi;

    db = await openDatabase(inMemoryDatabasePath,
        version: 1,
        onCreate: onCreate
    );
    provider.openInTest(db);
  });

  group("database test", () {
      test("Database add function", () async {
        final addDbItem = DBCalendarItem(
        name: "test", place: "test", details: "test",
        beginTimeString: "2022-4-27 08:00:00.000.000",
        endTimeString: "2022-4-27 09:00:00.000.000");

        await provider.create(addDbItem);

        final testItem = await provider.read(1);

        expect(testItem.name, "test");
        }
      );

      test("Database read function", () async {
        final provider = CalendarProvider();

        Database db = await openDatabase(inMemoryDatabasePath,
            version: 1,
            onCreate: onCreate
        );
        provider.openInTest(db);

        final addDbItem1 = DBCalendarItem(
            name: "test1", place: "test", details: "test",
            beginTimeString: "2022-4-27 08:00:00.000.000",
            endTimeString: "2022-4-27 09:00:00.000.000");
        final addDbItem2 = DBCalendarItem(
            name: "test2", place: "test", details: "test",
            beginTimeString: "2022-4-27 08:00:00.000.000",
            endTimeString: "2022-4-27 09:00:00.000.000");

        await provider.create(addDbItem1);
        await provider.create(addDbItem2);

        final List<DBCalendarItem> items = await provider.items();

        expect(items[0].name, "test");
        expect(items[1].place, "test");
        expect(items[2].beginTimeString, "2022-4-27 08:00:00.000.000");
        }
      );

      test("Database update function", () async{
        DBCalendarItem updateItem = await provider.read(2);
        updateItem.beginTimeString = "2022-4-25 08:00:00.000.000";

        await provider.update(updateItem);

        updateItem = await provider.read(2);

        expect(updateItem.beginTimeString, "2022-4-25 08:00:00.000.000");
        }
      );

      test("Database delete function", () async{
        await provider.delete(2);
        var items = await provider.items();

        expect(items.length, 2);

        }
      );
    }
  );

  tearDownAll(() async {
        await db.close();
  });
}

// 创建数据库时执行
Future onCreate(Database db, int version) async {
  await db.execute("create table Calendar"
      "(id integer primary key autoincrement, "
      "name text, place text, details text, "
      "beginTimeString text, "
      "endTimeString text)"
  );
}