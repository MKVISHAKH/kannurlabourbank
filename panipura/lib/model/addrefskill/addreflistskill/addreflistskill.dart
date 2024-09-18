import 'package:json_annotation/json_annotation.dart';

part 'addreflistskill.g.dart';

@JsonSerializable()
class Addreflistskill {
  @JsonKey(name: 'reference_id')
  int? referenceId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'skill_id')
  int? skillId;
  String? name;
  String? mobile;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Addreflistskill({
    this.referenceId,
    this.userId,
    this.skillId,
    this.name,
    this.mobile,
    this.updatedAt,
    this.createdAt,
  });

  factory Addreflistskill.fromJson(Map<String, dynamic> json) {
    return _$AddreflistskillFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddreflistskillToJson(this);
}
