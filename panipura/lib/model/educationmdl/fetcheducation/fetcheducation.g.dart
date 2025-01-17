// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetcheducation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fetcheducation _$FetcheducationFromJson(Map<String, dynamic> json) =>
    Fetcheducation(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetcheducationToJson(Fetcheducation instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
