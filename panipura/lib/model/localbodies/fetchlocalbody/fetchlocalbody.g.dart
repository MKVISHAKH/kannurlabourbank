// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetchlocalbody.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fetchlocalbody _$FetchlocalbodyFromJson(Map<String, dynamic> json) =>
    Fetchlocalbody(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetchlocalbodyToJson(Fetchlocalbody instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
