import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  String? name;
  @JsonKey(name: 'name_ml')
  String? nameMl;
  @JsonKey(name: 'localbody_id')
  int? localbodyId;

  Datum({this.name, this.nameMl, this.localbodyId});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
