// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletetodoreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deletetodoreq _$DeletetodoreqFromJson(Map<String, dynamic> json) =>
    Deletetodoreq(
      userId: (json['user_id'] as num?)?.toInt(),
      todolistId: (json['todolist_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeletetodoreqToJson(Deletetodoreq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'todolist_id': instance.todolistId,
    };
