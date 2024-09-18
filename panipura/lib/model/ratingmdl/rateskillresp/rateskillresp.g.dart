// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rateskillresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rateskillresp _$RateskillrespFromJson(Map<String, dynamic> json) =>
    Rateskillresp(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$RateskillrespToJson(Rateskillresp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
