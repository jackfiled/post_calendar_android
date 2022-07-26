import 'package:json_annotation/json_annotation.dart';

part 'course_info_json.g.dart';

@JsonSerializable()
class CourseInfoJson {
  String name;
  String teacher;
  String place;
  List<int> weeks;
  String beginTimeString;
  String endTimeString;
  int dayOfWeek;

  CourseInfoJson({required this.name,
    required this.teacher,
    required this.place,
    required this.weeks,
    required this.beginTimeString,
    required this.endTimeString,
    required this.dayOfWeek});

  factory CourseInfoJson.fromJson(Map<String, dynamic> json) =>
      _$CourseInfoJsonFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInfoJsonToJson(this);
}
