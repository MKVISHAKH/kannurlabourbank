import 'package:json_annotation/json_annotation.dart';

part 'ratingreqmdl.g.dart';

@JsonSerializable()
class Ratingreqmdl {
  @JsonKey(name: 'employer_id')
  int? employerId;
  @JsonKey(name: 'user_id')
  int? userId;
  double? rating;
  @JsonKey(name: 'skill_id')
  int? skillId;
  String? comments;

  Ratingreqmdl({
    this.employerId,
    this.userId,
    this.rating,
    this.skillId,
    this.comments,
  });
  Ratingreqmdl.req({
    required this.employerId,
    required this.userId,
    required this.rating,
    required this.skillId,
    required this.comments,
  });

  factory Ratingreqmdl.fromJson(Map<String, dynamic> json) {
    return _$RatingreqmdlFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RatingreqmdlToJson(this);
}
