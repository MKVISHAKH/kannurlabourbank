import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  int? rating;
  @JsonKey(name: 'employer_id')
  String? employerId;
  @JsonKey(name: 'skill_id')
  String? skillId;
  String? comments;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'rating_id')
  int? ratingId;

  Data({
    this.rating,
    this.employerId,
    this.skillId,
    this.comments,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.ratingId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
