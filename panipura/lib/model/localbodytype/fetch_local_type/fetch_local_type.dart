import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetch_local_type.g.dart';

@JsonSerializable()
class FetchLocalType {
  bool? success;
  List<Datum>? data;
  String? message;

  FetchLocalType({this.success, this.data, this.message});

  factory FetchLocalType.fromJson(Map<String, dynamic> json) {
    return _$FetchLocalTypeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetchLocalTypeToJson(this);
}
