// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleteresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deleteresp _$DeleterespFromJson(Map<String, dynamic> json) => Deleteresp(
      message: json['message'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$DeleterespToJson(Deleteresp instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
