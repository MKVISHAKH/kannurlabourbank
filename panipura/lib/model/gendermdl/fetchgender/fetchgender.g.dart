// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetchgender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fetchgender _$FetchgenderFromJson(Map<String, dynamic> json) => Fetchgender(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetchgenderToJson(Fetchgender instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
