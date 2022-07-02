/// 日历事件模型
class CalendarModel{
    int? id;
    String name;
    String place;
    String details;
    DateTime beginTime;
    DateTime endTime;

    static const double _columnHeight = 80.0;

    CalendarModel.inner({
        required this.name,
        required this.place,
        required this.details,
        required this.beginTime,
        required this.endTime});

    double get topDistance =>
        beginTime.hour * _columnHeight +
            beginTime.minute * _columnHeight / 60.0 +
            beginTime.second * _columnHeight / 3600.0;

    double get length =>
        (endTime.hour - beginTime.hour) * _columnHeight +
            (endTime.minute - beginTime.minute) * _columnHeight / 60.0 +
            (endTime.second - beginTime.second) * _columnHeight / 3600.0;
}