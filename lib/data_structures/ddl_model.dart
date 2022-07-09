import 'package:post_calendar_android/database/ddl_provider.dart';

class DDLModel {
  int? id;
  late String name;
  late String details;
  late DateTime endTime;
  late int type;

  /// 内部新建对象
  DDLModel(
      {required this.name,
      required this.details,
      required this.endTime,
      required this.type});

  DDLModel.fromDB(Map<String, dynamic> map) {
    id = map[DDLProvider.columnId];
    name = map[DDLProvider.columnName];
    details = map[DDLProvider.columnDetails];
    endTime = DateTime.parse(map[DDLProvider.columnEndTime]);
    type = map[DDLProvider.columnType];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DDLProvider.columnName: name,
      DDLProvider.columnDetails: details,
      DDLProvider.columnEndTime: endTime.toString(),
      DDLProvider.columnType: type
    };

    if (id != null) {
      map[DDLProvider.columnId] = id;
    }

    return map;
  }
}
