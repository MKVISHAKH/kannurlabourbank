// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addskillresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Addskillresp _$AddskillrespFromJson(Map<String, dynamic> json) => Addskillresp(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddskillrespToJson(Addskillresp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
