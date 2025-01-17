// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetchoccupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fetchoccupation _$FetchoccupationFromJson(Map<String, dynamic> json) =>
    Fetchoccupation(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetchoccupationToJson(Fetchoccupation instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
