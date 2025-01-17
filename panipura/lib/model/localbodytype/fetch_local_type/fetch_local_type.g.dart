// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_local_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchLocalType _$FetchLocalTypeFromJson(Map<String, dynamic> json) =>
    FetchLocalType(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetchLocalTypeToJson(FetchLocalType instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
