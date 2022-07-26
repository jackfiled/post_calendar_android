// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SemesterInfo _$SemesterInfoFromJson(Map<String, dynamic> json) => SemesterInfo(
      id: json['id'] as int,
      semester: json['semester'] as String,
      beginDateTimeString: json['beginDateTimeString'] as String,
    );

Map<String, dynamic> _$SemesterInfoToJson(SemesterInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'semester': instance.semester,
      'beginDateTimeString': instance.beginDateTimeString,
    };
