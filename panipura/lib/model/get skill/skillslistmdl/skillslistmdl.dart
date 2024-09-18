import 'package:json_annotation/json_annotation.dart';

part 'skillslistmdl.g.dart';

@JsonSerializable()
class Skillslistmdl {
  @JsonKey(name: 'skill_id')
  int? skillId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  @JsonKey(name: 'occupation_name')
  String? occupationname;
  String? experience;
  int? wages;
  @JsonKey(name: 'w_period')
  String? wPeriod;
  @JsonKey(name: 'willing_panchayath')
  DateTime? willingpanchayath;
  @JsonKey(name: 'additional_info')
  String? additionalInfo;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  String? skillname;
  String? error;

  Skillslistmdl({
    this.skillId,
    this.userId,
    this.occupationId,
    this.occupationname,
    this.experience,
    this.wages,
    this.wPeriod,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
    this.skillname,
    this.error,
  });

  factory Skillslistmdl.fromJson(Map<String, dynamic> json) {
    return _$SkillslistmdlFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SkillslistmdlToJson(this);
}
