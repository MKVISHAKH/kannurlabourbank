// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtodolistreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addtodolist _$AddtodolistFromJson(Map<String, dynamic> json) => Addtodolist(
      userId: (json['user_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      frmDt: json['frm_dt'] as String?,
      toDt: json['to_dt'] as String?,
      frmTime: json['frm_time'] as String?,
      toTime: json['to_time'] as String?,
      todolistId: (json['todolist_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddtodolistToJson(Addtodolist instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'frm_dt': instance.frmDt,
      'to_dt': instance.toDt,
      'frm_time': instance.frmTime,
      'to_time': instance.toTime,
      'todolist_id': instance.todolistId,
    };
