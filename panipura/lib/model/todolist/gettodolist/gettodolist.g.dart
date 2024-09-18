// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gettodolist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gettodolist _$GettodolistFromJson(Map<String, dynamic> json) => Gettodolist(
      todolistId: json['todolist_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      frmDt: json['frm_dt'] as String?,
      toDt: json['to_dt'] as String?,
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
    );

Map<String, dynamic> _$GettodolistToJson(Gettodolist instance) =>
    <String, dynamic>{
      'todolist_id': instance.todolistId,
      'title': instance.title,
      'description': instance.description,
      'frm_dt': instance.frmDt,
      'to_dt': instance.toDt,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
