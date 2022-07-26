import 'package:json_annotation/json_annotation.dart';

part 'semester_info.g.dart';

@JsonSerializable()
class SemesterInfo {
  int id;
  String semester;
  String beginDateTimeString;

  SemesterInfo({
    required this.id,
    required this.semester,
    required this.beginDateTimeString
  });

  factory SemesterInfo.fromJson(Map<String, dynamic> json) => _$SemesterInfoFromJson(json);

  Map<String, dynamic> toMap() => _$SemesterInfoToJson(this);
}
