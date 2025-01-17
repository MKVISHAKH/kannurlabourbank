// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      name: json['name'] as String?,
      typeId: json['type_id'] as String?,
      userId: json['user_id'] as String?,
      path: json['path'] as String?,
      size: (json['size'] as num?)?.toInt(),
      title: json['title'],
      description: json['description'],
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      fileId: (json['file_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'type_id': instance.typeId,
      'user_id': instance.userId,
      'path': instance.path,
      'size': instance.size,
      'title': instance.title,
      'description': instance.description,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'file_id': instance.fileId,
    };
