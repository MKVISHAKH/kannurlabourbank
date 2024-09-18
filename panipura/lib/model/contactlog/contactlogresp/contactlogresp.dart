import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'contactlogresp.g.dart';

@JsonSerializable()
class Contactlogresp {
  bool? success;
  Data? data;
  String? message;

  Contactlogresp({this.success, this.data, this.message});

  factory Contactlogresp.fromJson(Map<String, dynamic> json) {
    return _$ContactlogrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContactlogrespToJson(this);
}
