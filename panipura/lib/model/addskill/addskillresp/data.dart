import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  String? experience;
  String? wages;
  @JsonKey(name: 'w_period')
  String? wPeriod;
  @JsonKey(name: 'additional_info')
  String? additionalInfo;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'skill_id')
  int? skillId;
  String? error;

  Data({
    this.userId,
    this.occupationId,
    this.experience,
    this.wages,
    this.wPeriod,
    this.additionalInfo,
    this.updatedAt,
    this.createdAt,
    this.skillId,
    this.error,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
