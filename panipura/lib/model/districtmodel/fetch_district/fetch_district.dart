import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetch_district.g.dart';

@JsonSerializable()
class FetchDistrict {
  bool? success;
  List<Datum>? data;
  @JsonKey(name: 'message')
  String? message;

  FetchDistrict({this.success, this.data, this.message});

  factory FetchDistrict.fromJson(Map<String, dynamic> json) {
    return _$FetchDistrictFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetchDistrictToJson(this);
}
