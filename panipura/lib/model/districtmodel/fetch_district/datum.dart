import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'district_id')
  int? districtId;
  String? name;
  @JsonKey(name: 'name_ml')
  String? nameMl;

  Datum({this.districtId, this.name, this.nameMl});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
