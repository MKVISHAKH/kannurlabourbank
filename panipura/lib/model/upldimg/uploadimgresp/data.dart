import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  String? name;
  @JsonKey(name: 'type_id')
  String? typeId;
  @JsonKey(name: 'user_id')
  String? userId;
  String? path;
  int? size;
  dynamic title;
  dynamic description;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'file_id')
  int? fileId;

  Data({
    this.name,
    this.typeId,
    this.userId,
    this.path,
    this.size,
    this.title,
    this.description,
    this.updatedAt,
    this.createdAt,
    this.fileId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
