// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploadimgresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uploadimgresp _$UploadimgrespFromJson(Map<String, dynamic> json) =>
    Uploadimgresp(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UploadimgrespToJson(Uploadimgresp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
