import 'package:test/test.dart';
import 'package:post_calendar_android/Models/Database.dart';

void main() async {
  test("Database add function", () async {
      final dbHelper = DBCalendarHelper();
      final addDbItem = DBCalendarItem(
          name: "test", place: "test", details: "test",
          beginTimeString: "2022-4-27 08:00:00.000.000",
          endTimeString: "2022-4-27 09:00:00.000.000");

      await dbHelper.create(addDbItem);

      final testItem = await dbHelper.readItem(1);

      expect(testItem, "test");
    }
  );

  test("Database read function", () async {
      final dbHelper = DBCalendarHelper();
      final addDbItem1 = DBCalendarItem(
          name: "test1", place: "test", details: "test",
          beginTimeString: "2022-4-27 08:00:00.000.000",
          endTimeString: "2022-4-27 09:00:00.000.000");
      final addDbItem2 = DBCalendarItem(
          name: "test2", place: "test", details: "test",
          beginTimeString: "2022-4-27 08:00:00.000.000",
          endTimeString: "2022-4-27 09:00:00.000.000");

      await dbHelper.create(addDbItem1);
      await dbHelper.create(addDbItem2);

      final List<DBCalendarItem> items = await dbHelper.items();

      expect(items[0].name, "test1");
      expect(items[1].name, "test2");
    }
  );

}