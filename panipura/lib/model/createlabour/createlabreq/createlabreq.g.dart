// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createlabreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Createlabreq _$CreatelabreqFromJson(Map<String, dynamic> json) => Createlabreq(
      name: json['name'] as String?,
      address: json['address'] as String?,
      place: json['place'] as String?,
      post: json['post'] as String?,
      pin: json['pin'] as String?,
      genderId: json['gender_id'] as int?,
      districtId: json['district_id'] as int?,
      blockId: json['block_id'] as int?,
      localbodyId: json['localbody_id'] as int?,
      dob: json['dob'] as String?,
      aadhaar: json['aadhaar'] as String?,
      mobile: json['mobile'] as String?,
      educationId: json['education_id'] as int?,
      category: json['category'] as int?,
      password: json['password'] as String?,
      cPassword: json['c_password'] as String?,
    );

Map<String, dynamic> _$CreatelabreqToJson(Createlabreq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'place': instance.place,
      'post': instance.post,
      'pin': instance.pin,
      'gender_id': instance.genderId,
      'district_id': instance.districtId,
      'block_id': instance.blockId,
      'localbody_id': instance.localbodyId,
      'dob': instance.dob,
      'aadhaar': instance.aadhaar,
      'mobile': instance.mobile,
      'education_id': instance.educationId,
      'category': instance.category,
      'password': instance.password,
      'c_password': instance.cPassword,
    };
