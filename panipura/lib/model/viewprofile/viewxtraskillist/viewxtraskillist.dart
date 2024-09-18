import 'package:json_annotation/json_annotation.dart';

part 'viewxtraskillist.g.dart';

@JsonSerializable()
class Viewxtraskillist {
  @JsonKey(name: 'skill_id')
  int? skillId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  String? experience;
  int? wages;
  @JsonKey(name: 'w_period')
  String? wPeriod;
  @JsonKey(name: 'additional_info')
  String? additionalInfo;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Viewxtraskillist({
    this.skillId,
    this.userId,
    this.occupationId,
    this.experience,
    this.wages,
    this.wPeriod,
    this.additionalInfo,
    this.createdAt,
    this.updatedAt,
  });

  factory Viewxtraskillist.fromJson(Map<String, dynamic> json) {
    return _$ViewxtraskillistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ViewxtraskillistToJson(this);
}
