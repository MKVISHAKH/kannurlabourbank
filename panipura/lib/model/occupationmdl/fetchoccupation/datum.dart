import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'occupation_id')
  int? occupationId;
  String? name;
  @JsonKey(name: 'name_ml')
  String? nameMl;
  @JsonKey(name: 'type_id')
  int? typeId;
  dynamic qualification;
  @JsonKey(name: 'qualification_ml')
  dynamic qualificationMl;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Datum({
    this.occupationId,
    this.name,
    this.nameMl,
    this.typeId,
    this.qualification,
    this.qualificationMl,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
