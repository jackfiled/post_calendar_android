// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'squid_ddl_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquidDDLModel _$SquidDDLModelFromJson(Map<String, dynamic> json) =>
    SquidDDLModel(
      index_: json['index_'] as int,
      noticeType: json['noticeType'] as int,
      title: json['title'] as String,
      time: json['time'] as String,
      ddl: json['ddl'] as String,
      detail: json['detail'] as String,
      img: json['img'] as String?,
      startTime: json['startTime'] as String?,
    );

Map<String, dynamic> _$SquidDDLModelToJson(SquidDDLModel instance) =>
    <String, dynamic>{
      'index_': instance.index_,
      'noticeType': instance.noticeType,
      'title': instance.title,
      'time': instance.time,
      'startTime': instance.startTime,
      'ddl': instance.ddl,
      'detail': instance.detail,
      'img': instance.img,
    };
