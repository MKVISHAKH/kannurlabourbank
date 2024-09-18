import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'addskillresp.g.dart';

@JsonSerializable()
class Addskillresp {
  bool? success;
  Data? data;
  String? message;

  Addskillresp({this.success, this.data, this.message});

  factory Addskillresp.fromJson(Map<String, dynamic> json) {
    return _$AddskillrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddskillrespToJson(this);
}
