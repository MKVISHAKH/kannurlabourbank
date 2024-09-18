import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'id')
  int? userId;
  @JsonKey(name: 'employer_id')
  int? employerId;
  String? name;
  String? address;
  String? place;
  String? post;
  String? pin;
  @JsonKey(name: 'gender_id')
  int? genderId;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'block_id')
  int? blockId;
  @JsonKey(name: 'localbody_id')
  int? localbodyId;
  String? dob;
  String? aadhaar;
  String? mobile;
  @JsonKey(name: 'education_id')
  int? educationId;
  int? category;
  dynamic email;
  @JsonKey(name: 'email_verified_at')
  dynamic emailVerifiedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  String? token;
  String? error;
  @JsonKey(name: 'mobile_verified')
  String? mobileverified;
  Data({
    this.userId,
    this.employerId,
    this.name,
    this.address,
    this.place,
    this.post,
    this.pin,
    this.genderId,
    this.districtId,
    this.blockId,
    this.localbodyId,
    this.dob,
    this.aadhaar,
    this.mobile,
    this.educationId,
    this.category,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.error,
    this.mobileverified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
