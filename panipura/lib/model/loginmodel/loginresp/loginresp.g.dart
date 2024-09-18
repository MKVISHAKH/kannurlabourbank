// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginresp _$LoginrespFromJson(Map<String, dynamic> json) => Loginresp(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginrespToJson(Loginresp instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
