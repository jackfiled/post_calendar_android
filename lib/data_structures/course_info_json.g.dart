// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_info_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInfoJson _$CourseInfoJsonFromJson(Map<String, dynamic> json) =>
    CourseInfoJson(
      name: json['name'] as String,
      teacher: json['teacher'] as String,
      place: json['place'] as String,
      weeks: (json['weeks'] as List<dynamic>).map((e) => e as int).toList(),
      beginTimeString: json['beginTimeString'] as String,
      endTimeString: json['endTimeString'] as String,
      dayOfWeek: json['dayOfWeek'] as int,
    );

Map<String, dynamic> _$CourseInfoJsonToJson(CourseInfoJson instance) =>
    <String, dynamic>{
      'name': instance.name,
      'teacher': instance.teacher,
      'place': instance.place,
      'weeks': instance.weeks,
      'beginTimeString': instance.beginTimeString,
      'endTimeString': instance.endTimeString,
      'dayOfWeek': instance.dayOfWeek,
    };
