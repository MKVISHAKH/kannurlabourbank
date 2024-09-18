import 'package:json_annotation/json_annotation.dart';

part 'getskillratelist.g.dart';

@JsonSerializable()
class Getskillratelist {
  @JsonKey(name: 'rating_id')
  int? ratingId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'employer_id')
  int? employerId;
  @JsonKey(name: 'skill_id')
  int? skillId;
  int? rating;
  String? comments;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'skill_name')
  String? skillName;
  @JsonKey(name: 'employer_name')
  String? employerName;

  Getskillratelist({
    this.ratingId,
    this.userId,
    this.employerId,
    this.skillId,
    this.rating,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.skillName,
    this.employerName,
  });

  factory Getskillratelist.fromJson(Map<String, dynamic> json) {
    return _$GetskillratelistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetskillratelistToJson(this);
}
