import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'contact_time')
  String? contactTime;
  @JsonKey(name: 'employer_id')
  int? employerId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'contact_id')
  int? contactId;

  Data({
    this.contactTime,
    this.employerId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.contactId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
