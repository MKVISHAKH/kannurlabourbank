// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createlabresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Createlabresp _$CreatelabrespFromJson(Map<String, dynamic> json) =>
    Createlabresp(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CreatelabrespToJson(Createlabresp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
