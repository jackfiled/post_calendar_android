import 'package:post_calendar_android/database/calendar_provider.dart';

/// 日历事件模型
class CalendarModel{
    int? id;
    late String name;
    late String place;
    late String details;
    late DateTime beginTime;
    late DateTime endTime;

    static const double _columnHeight = 80.0;

    /// 内部新建对象
    CalendarModel.inner({
        required this.name,
        required this.place,
        required this.details,
        required this.beginTime,
        required this.endTime});

    // 不得不说dart的空安全检查不是很智能的样子
    // 这里我明明初始化了所有不能为空的对象
    // 还是提醒我没有初始化
    /// 从数据库初始化对象
    CalendarModel.fromDB(Map<String, dynamic> map){
        id = map[CalendarProvider.columnId];
        name = map[CalendarProvider.columnName];
        place = map[CalendarProvider.columnPlace];
        details = map[CalendarProvider.columnDetails];
        beginTime = DateTime.parse(map[CalendarProvider.columnBeginTime]);
        endTime = DateTime.parse(map[CalendarProvider.columnEndTime]);
    }

    double get topDistance =>
        (beginTime.hour - 8) * _columnHeight + //在计算顶部的高度时考虑开始时间为8点
            beginTime.minute * _columnHeight / 60.0 +
            beginTime.second * _columnHeight / 3600.0;

    double get length =>
        (endTime.hour - beginTime.hour) * _columnHeight +
            (endTime.minute - beginTime.minute) * _columnHeight / 60.0 +
            (endTime.second - beginTime.second) * _columnHeight / 3600.0;

    Map<String, dynamic> toMap(){
        var map = <String, dynamic>{
            CalendarProvider.columnName: name,
            CalendarProvider.columnPlace: place,
            CalendarProvider.columnDetails: details,
            CalendarProvider.columnBeginTime: beginTime.toString(),
            CalendarProvider.columnEndTime: endTime.toString()
        };

        // 处理id不为空的情况
        if(id != null){
            map[CalendarProvider.columnId] = id;
        }

        return map;
    }
}