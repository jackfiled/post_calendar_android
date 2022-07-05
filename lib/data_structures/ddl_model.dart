import 'package:post_calendar_android/database/ddl_provider.dart';

class DDLModel{
  int? id;
  late String name;
  late String place;
  late String details;
  late DateTime endTime;

  /// 内部新建对象
  DDLModel({
    required this.name,
    required this.place,
    required this.details,
    required this.endTime
});

  DDLModel.fromDB(Map<String, dynamic> map){
    id = map[DDLProvider.columnId];
    name = map[DDLProvider.columnName];
    place = map[DDLProvider.columnPlace];
    details = map[DDLProvider.columnDetails];
    endTime = DateTime.parse(map[DDLProvider.columnEndTime]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DDLProvider.columnName: name,
      DDLProvider.columnPlace: place,
      DDLProvider.columnDetails: details,
      DDLProvider.columnEndTime: endTime.toString(),
    };

    if(id != null){
      map[DDLProvider.columnId] = id;
    }

    return map;
  }
}