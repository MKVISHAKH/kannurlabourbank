import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'fetchgender.g.dart';

@JsonSerializable()
class Fetchgender {
  bool? success;
  List<Datum>? data;
  String? message;

  Fetchgender({this.success, this.data, this.message});

  factory Fetchgender.fromJson(Map<String, dynamic> json) {
    return _$FetchgenderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FetchgenderToJson(this);
}
