import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'rateskillresp.g.dart';

@JsonSerializable()
class Rateskillresp {
  bool? success;
  Data? data;
  String? message;

  Rateskillresp({this.success, this.data, this.message});

  factory Rateskillresp.fromJson(Map<String, dynamic> json) {
    return _$RateskillrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RateskillrespToJson(this);
}
