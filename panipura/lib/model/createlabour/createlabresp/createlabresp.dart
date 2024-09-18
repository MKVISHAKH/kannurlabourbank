import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'createlabresp.g.dart';

@JsonSerializable()
class Createlabresp {
  bool? success;
  Data? data;
  String? message;

  Createlabresp({this.success, this.data, this.message});

  factory Createlabresp.fromJson(Map<String, dynamic> json) {
    return _$CreatelabrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreatelabrespToJson(this);
}
