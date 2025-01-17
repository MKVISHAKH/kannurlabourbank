// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_district.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchDistrict _$FetchDistrictFromJson(Map<String, dynamic> json) =>
    FetchDistrict(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FetchDistrictToJson(FetchDistrict instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };
