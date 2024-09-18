import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'uploadimgresp.g.dart';

@JsonSerializable()
class Uploadimgresp {
  bool? success;
  Data? data;
  String? message;

  Uploadimgresp({this.success, this.data, this.message});

  factory Uploadimgresp.fromJson(Map<String, dynamic> json) {
    return _$UploadimgrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UploadimgrespToJson(this);
}
