import 'package:json_annotation/json_annotation.dart';

part 'squid_ddl_json.g.dart';

/// JSON序列化对象
@JsonSerializable()
class SquidDDLModel{
  int index_;
  int noticeType;
  String title;
  String time;
  String? startTime;
  String ddl;
  String detail;
  String? img;

  SquidDDLModel({
    required this.index_,
    required this.noticeType,
    required this.title,
    required this.time,
    required this.ddl,
    required this.detail,
    required this.img,
    required this.startTime
  });

  factory SquidDDLModel.fromJson(Map<String, dynamic> json) =>
      _$SquidDDLModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SquidDDLModelToJson(this);
}