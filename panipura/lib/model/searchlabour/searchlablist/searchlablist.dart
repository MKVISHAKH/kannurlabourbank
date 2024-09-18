import 'package:json_annotation/json_annotation.dart';

part 'searchlablist.g.dart';

@JsonSerializable()
class Searchlablist {
  @JsonKey(name: 'skill_id')
  int? skillId;
  @JsonKey(name: 'user_id')
  int? userId;
  String? name;
  String? place;
  String? dob;
  String? mobile;
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  @JsonKey(name: 'occupation_name')
  String? occupationName;
  String? experience;
  int? wages;
  @JsonKey(name: 'w_period')
  String? wPeriod;
  @JsonKey(name: 'additional_info')
  String? additionalInfo;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  String? rating;

  Searchlablist(
      {this.skillId,
      this.userId,
      this.name,
      this.place,
      this.dob,
      this.mobile,
      this.occupationId,
      this.occupationName,
      this.experience,
      this.wages,
      this.wPeriod,
      this.additionalInfo,
      this.createdAt,
      this.updatedAt,
      this.rating});

  factory Searchlablist.fromJson(Map<String, dynamic> json) {
    return _$SearchlablistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchlablistToJson(this);
}
